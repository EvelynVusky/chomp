(* Semantic checking for the MicroC compiler *)

open Ast
open Sast

module StringMap = Map.Make(String)

exception TypeError of string
exception NotFoundError of string
exception DupError of string
exception VoidError of string
exception ReturnError of string
exception InvalidError of string

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
    let _ =
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

  (* checks if 2 types are equal, raises error if they are not, poly or bin type must be second arugment *)
  let eq_type_err ty1 ty2 = 
    match ty2 with 
    Poly -> true
    | Bin ->
      (match ty1 with
        Bit -> true
        | Nibble -> true
        | Byte -> true
        | Word -> true
        | _ -> raise (TypeError ("Types " ^ string_of_typ ty1 ^ " and " ^ string_of_typ ty2 ^ " don't match")))
    | _ ->
      if ty1 <> ty2 
        then raise (TypeError ("Types " ^ string_of_typ ty1 ^ " and " ^ string_of_typ ty2 ^ " don't match"))
      else true
  in

  (* checks if 2 types are equal, returns true if they are, false otherwise *)
  let eq_type ty1 ty2 = function
    (_, Poly) -> true
    | (ty, Bin) ->
      (match ty with
        Bit -> true
        | Nibble -> true
        | Byte -> true
        | Word -> true
        | _ -> false)
    | _ ->
      if ty1 <> ty2 
        then false
      else true
  in

  (************************** Convert Exprs **************************)
  
  (* converts expr from AST to SAST form *)
  (* must convert poly type here *)
  let rec convert_expr scope e = match e with
    Literal l -> (scope, (Int, SLiteral(l)))
    | BoolLit b -> (scope, (Bool, SBoolLit(b)))
    | CharLit c -> (scope, (Char, SCharLit(c)))
    | StringLit s -> (scope, (String, SStringLit(s)))
    | BinLit b -> (scope, (Bin, SBinLit(b)))
    | Id s -> (scope, (Int, SLiteral(1)))
    | Binop (e1, o, e2) -> (scope, (Int, SLiteral(1)))
    | Unop (u, e) -> (scope, (Int, SLiteral(1)))
    | Assign (s, e)-> (scope, (Int, SLiteral(1)))
    | Call (name, es) -> 
      (* find name in scope, match formals length & type *)
      let call_type = find_variable scope name in
      let (formals, ret) = (match call_type with
        Func(formals, ret) -> (formals, ret)
        | _ -> raise (InvalidError (string_of_typ call_type ^ " should be an fdecl")))
      in
        let check_call ft e = 
        let (_, (et, e')) = convert_expr scope e in
        let _ = eq_type_err et ft
        in (et, e')
      in 
      let args' = List.map2 check_call formals es 
      in (scope, (ret, SCall(name, args')))
    | List es -> (scope, (Int, SLiteral(1)))
    | Noexpr -> (scope, (Int, SLiteral(1)))
    | Null -> (scope, (Int, SLiteral(1)))
  in

  (************************** Convert Statements **************************)

  (* converts stmt from AST to SAST form *)
  let rec convert_stmt scope stmt = match stmt with
    Expr(e) -> 
      let (scope', sexpr) = (convert_expr scope e)
      in (scope', SExpr(sexpr))
    | Return(e) -> (scope, SReturn((Int, SLiteral(1))))
    | If(e1, st1, st2) -> (scope, SReturn((Int, SLiteral(1))))
    | For(e1, e2, e3, st) -> (scope, SReturn((Int, SLiteral(1))))
    | While(e, st) -> (scope, SReturn((Int, SLiteral(1))))
    | Var(vdecl) -> (scope, SReturn((Int, SLiteral(1))))
    | Block(sl) -> 
        let new_scope = {
            variables = StringMap.empty;
            parent = Some(scope);
          }
        in
        let rec convert_stmt_list new_scope stmt_list = match stmt_list with
          | [Return _ as stmt] ->
              let new_scope', sstmt = convert_stmt new_scope stmt in
              (new_scope', [sstmt])
          | Return _ as r :: _ ->
            raise (ReturnError (string_of_stmt r ^ " should not be after a Return statement"))
          | s :: ss ->
              let new_scope', stmt1 = convert_stmt new_scope s in
              let new_scope'', stmt2 = convert_stmt_list new_scope' ss in
              (new_scope'', stmt1 :: stmt2)
          | [] -> (new_scope, [])
        in
        let _, stmt_list = convert_stmt_list new_scope sl in
        (* return to parent scope *)
        (scope, SBlock stmt_list)
  in
  
  (************************** Checking Variables **************************)

  (* check global variables and add to scope*)
  let check_vdecls (scope, acc) (vdecl: vdecl) = 
    (* extract attributes of vdecl *)
    let typ = vdecl.typ 
    and vname = vdecl.vname 
    and value = vdecl.value in

    (* expr: evaluate expr *)
    let _, sexpr = convert_expr scope value in

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
    
    (* check function body *)
    let _, sstmt_list = convert_stmt new_scope' (Block body) in
    
    (* check return type of function *)
    let _ = (match typ with
        Void -> (match sstmt_list with
                SBlock(SReturn((ret_typ, _)) :: _) -> eq_type_err ret_typ Void 
                | _ -> true)
        | _ -> (match sstmt_list with
              SBlock(SReturn((ret_typ, _)) :: _) -> eq_type_err ret_typ typ
              | _ -> (raise (ReturnError ("No return statement found")))))
    in

    let sstmt_list' = match sstmt_list with
      SBlock(list) -> List.rev list
      | _ -> (raise (InvalidError ("Function body should be in a Block")))
    in

    (
      scope',
      {
        styp = typ;
        sfname = fname;
        sformals = formals;
        sbody = sstmt_list';
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