(* Semantic checking for the MicroC compiler *)

open Ast
open Sast

module StringMap = Map.Make(String)

exception TypeError of string
exception NotFoundError of string
exception DupError of string
exception VoidError of string
exception InvalidError of string
exception TodoError

type symbol_table = {
  variables: typ StringMap.t;
  parent: symbol_table option;
}

(* Semantic checking of the AST. Returns an SAST if successful,
   throws an exception if something is wrong.

   Check each global variable, then check each function *)

let check (vdecls, fdecls) = 
  (************************** Helper Functions **************************)
  (* add built-in functions *)
  let built_in_funcs = 
    let add_built_in_funcs map (name, fms, ret) = StringMap.add name (Func(fms, ret)) map
    in
      List.fold_left add_built_in_funcs StringMap.empty [
        ("toBit", [Poly], Bit);
        ("toNibble", [Poly], Nibble);
        ("toByte", [Poly], Byte);
        ("toWord", [Poly], Word);
        ("toChar", [Poly], Char);
        ("toInt", [Poly], Int);
        ("set", [Bin; Int; Bin], Bin);
        ("flipBit", [Bin; Int], Bin);
        ("getBit", [Bit; Int], Bin);
        ("print", [Poly], Void);
        ("println", [Poly], Void);
      ]
  in

  (* add decls, checks for duplicates, and adds to scope *)
  let add_decl scope (typ, (vname : string)) =
    (* check no variables are duplicated or void typed *)
    let validate =
      if typ == Void then raise (VoidError ("void variable " ^ vname ^ " not allowed"))
      else 
        if StringMap.mem vname scope.variables == true
          then raise (DupError ("duplicate variable " ^ vname ^ " not allowed"))
    in
      let new_scope = 
        { 
          variables = StringMap.add vname typ scope.variables;
          parent = scope.parent;
        } 
      in new_scope
  in 

  (* finds variable in given scope *)
  let rec find_variable (scope: symbol_table) name = 
    try
      StringMap.find name scope.variables
    with Not_found -> 
      match scope.parent with 
        Some(parent) -> find_variable parent name
        | _          -> raise (NotFoundError ("unidentified id " ^ name))
  in

  (* checks if 2 types are equal, raises error if they are not *)
  let eq_type_err ty1 ty2 =
    if ty1 <> ty2 
      then raise (TypeError (string_of_typ ty1 ^ " " ^ string_of_typ ty2))
    else true
  in

  (* checks if 2 types are equal, returns true if they are, false otherwise *)
  let eq_type ty1 ty2 =
    if ty1 = ty2 
      then true
    else false
  in

  (************************** Convert Exprs **************************)
  
  (* converts expr from AST to SAST form *)
  (* must convert poly type here *)
  let rec convert_expr scope e = match e with
    Literal l -> (Int, SLiteral(1))
    | BoolLit b -> (Int, SLiteral(1))
    | CharLit c -> (Int, SLiteral(1)) 
    | StringLit s -> (Int, SLiteral(1))
    | Id s -> (Int, SLiteral(1))
    | Binop (e1, o, e2) -> (Int, SLiteral(1))
    | Unop (u, e) -> (Int, SLiteral(1))
    | Assign (s, e)-> (Int, SLiteral(1))
    | Call (s, es) -> (Int, SLiteral(1))
    | List es -> (Int, SLiteral(1))
    | Noexpr -> (Int, SLiteral(1))
    | BinLit s -> (Int, SLiteral(1))
    | Null -> (Int, SLiteral(1))
    | Print e -> (Int, SLiteral(1))
    | PrintLn e -> (Int, SLiteral(1))
    (* TODO: stringlit, call, assign (maybe) *)
  in

  (************************** Convert Statements **************************)

  (* converts stmt from AST to SAST form *)
  let rec convert_stmt (scope, acc) stmt = match stmt with
    (* TODO: block, expr, var (maybe) *)
    Block(e) -> (scope, SReturn((Int, SLiteral(1))) :: acc)
    | Return(e) -> (scope, SReturn((Int, SLiteral(1))) :: acc)
    | If(e1, st1, st2) -> (scope, SReturn((Int, SLiteral(1))) :: acc)
    | For(e1, e2, e3, st) -> (scope, SReturn((Int, SLiteral(1))) :: acc)
    | While(e, st) -> (scope, SReturn((Int, SLiteral(1))) :: acc)
    | Var(vdecl) -> (scope, SReturn((Int, SLiteral(1))) :: acc)
  in
  
  (************************** Checking Variables **************************)

  (* check global variables and add to scope*)
  let check_vdecls (scope, acc) (vdecl: vdecl) = 
    (* extract attributes of vdecl *)
    let typ = vdecl.typ 
    and vname = vdecl.vname 
    and value = vdecl.value in

    (* expr: evaluate expr *)
    let sexpr = convert_expr scope value in

    (* check type equality *) 
    (* NOTE: if type isn't equal, it's polymorphic? *)
    let _ = eq_type_err typ (fst sexpr) in
    
    (* add to scope *)
    let new_var = {
      styp = typ; 
      svname = vname; 
      svalue = sexpr;}
    in
    ((add_decl scope (typ, vname)), new_var :: acc)
  in 
  
  (************************** Checking Functions **************************)

  (* check each function and everything inside of them*)
  let check_fdecls (scope, acc) fdecl = 
    (* extract attributes of vdecl *)
    let typ = fdecl.typ 
    and fname = fdecl.fname 
    and formals = fdecl.formals
    and body = fdecl.body in

    (* validate name & add to scope *)
    let scope' =
      if StringMap.mem fname built_in_funcs 
        then raise (DupError ("built-in function defined with identifier " ^ fname))
      else add_decl scope (Func((List.map fst formals), typ), fname)
    in 

    (* make new scope, parent is scope that was passed in*)
    let new_scope = {variables = StringMap.empty; parent = Some(scope');} in
    
    (* check formals & add to new scope *)
    let new_scope' = List.fold_left add_decl new_scope formals in
    
    (* check funcyion body *)
    let _, sstmt_list = (List.fold_left convert_stmt (new_scope', []) body) in
    
    (* check return type of function *)
    let _ = match typ with
        Void -> match sstmt_list with
                (SReturn((ret_typ, _)) :: _) -> eq_type_err ret_typ Void 
                | _ -> true         
        | _ -> match sstmt_list with
              (SReturn((ret_typ, _)) :: _) -> eq_type_err ret_typ typ
              | _ -> (raise (TypeError ("no return statement found")))
    in

    (
      scope',
      {
        styp = typ;
        sfname = fname;
        sformals = formals;
        sbody = sstmt_list;
      } :: acc
    )
  in

  (************************** Driver code **************************)

  (* adds built in functions to scope *)
  (* NOTE: it feels like we're treating scope as an obj everywhere except here *)
  let scope = {variables = built_in_funcs; parent = None;} in
  (* let scope = scope_obj ref in *)

  (* add global variables to same scope *)
  let scope, globals' = List.fold_left check_vdecls (scope, []) vdecls in

  (* adds user defined functions to scope *)
  let scope, functions' = List.fold_left check_fdecls (scope, []) fdecls in

  (* check main *)
  let _ = find_variable scope "main" in

  (List.rev globals', List.rev functions')