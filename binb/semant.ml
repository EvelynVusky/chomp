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
        ("toBit", [Bin], Bit);
        ("intToBit", [Int], Bit);
        ("charToBit", [Char], Bit);
        ("toNibble", [Bin], Nibble);
        ("intToNibble", [Int], Nibble);
        ("charToNibble", [Char], Nibble);
        ("toByte", [Bin], Byte);
        ("intToByte", [Int], Byte);
        ("charToByte", [Char], Byte);
        ("toWord", [Bin], Word);
        ("intToWord", [Int], Word);
        ("charToWord", [Char], Word);
        ("toInt", [Bin], Int);
        ("setBit", [Bin; Int; Bit], Bin);
        ("flipBit", [Bin; Int], Bin);
        ("getBit", [Bin; Int], Bit);
        ("toChar", [Bin], Char);
        ("print", [Poly], Void);
        ("println", [Poly], Void);
        ("isEmpty", [List Poly], Bool);
      ]
  in

  (* finds variable in given scope, returns true if in scope, else false *)
  let rec find_variable_bool (scope: symbol_table) name = 
    try
      let _ = StringMap.find name scope.variables in 
      true
    with Not_found -> 
      (match scope.parent with 
        Some(parent) -> find_variable_bool parent name
        | _          -> false )
  in

  (* add decls, checks for duplicates, and adds to scope *)
  let add_decl scope (typ, (vname : string)) =
    (* check no variables are duplicated or void typed *)
    let _ =
      if typ == Void then raise (VoidError ("void variable " ^ vname ^ " not allowed"))
      else 
        if find_variable_bool scope vname == true
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

  (* returns true if type is primitive (incl. lists) and not void. else, returns false. *)
  let is_primitive_and_not_void ty = match ty with
    Void -> false
    | Func _ -> false
    | Bin -> false
    | Poly -> false
    | _ -> true
  in

  (* returns true if 2 types are equal, and false if not. only ty2 can be Poly or Bin. *)
  let rec eq_type ty1 ty2 =
    let eq_type_helper ty1 ty2 = match ty1 with
      (* only ty2 can be a Poly or Bin type (not usable by user) *)
      Poly -> if ty2 = Poly then true else false
      | Bin -> false
      | Func _ -> false
      | _ -> 
        match ty2 with
        (* if ty2 is Poly, return true if ty1 is a primitive (not a list or function) and not void *)
        Poly -> if (is_primitive_and_not_void ty1) then true else false
        | Bin -> (match ty1 with
            Bit -> true
            | Nibble -> true
            | Byte -> true
            | Word -> true
            | _ -> false)
        | List ty2' -> (match ty1 with
            (* if both are lists, recurse on internal type of list. else, they don't match *)
            List ty1' -> (match (ty2', ty1') with 
                          (List _, _) -> false
                          | (_, List _) -> false
                          |  _ -> eq_type ty1' ty2')
            | _ -> false)
        | Func _ -> false
        | _ -> 
          if ty1 <> ty2 
            then false
          else true
      in
      ((eq_type_helper ty1 ty2) || (eq_type_helper ty2 ty1))
    in

  (* returns true if 2 types are equal, and raises an error if not. only ty2 can be Poly or Bin. *)
  let eq_type_err ty1 ty2 = 
    if eq_type ty1 ty2 then true
    else raise (TypeError ("Types " ^ string_of_typ ty1 ^ " and " ^ string_of_typ ty2 ^ " don't match"))
  in

  (* returns true if ty1 is a bin type. else, false. *)
  let is_bin ty = (match ty with
      Bit -> true
      | Nibble -> true
      | Byte -> true
      | Word -> true
      | _ -> false)
  in 

  (* returns true in ty1 is the larger bin type *)
  let is_larger_bin ty1 ty2 =
    match (ty1, ty2) with
      (Bit, _) -> false
      | (_, Bit) -> true
      | (Nibble, Byte) -> false
      | (Byte, Nibble) -> false
      | (Word, _) -> true
      | (_, Word) -> false
      | _ -> raise (TypeError ((string_of_typ ty1) ^ " or " ^ (string_of_typ ty2) ^ "not Bin types"))
  in
    
  (* returns the smaller of 2 bin types *)
  let get_smaller_bin ty1 ty2 =
    if ty1 = ty2 then ty1
    else
      if is_larger_bin ty1 ty2 then ty2
      else ty1
  in

  let rec eq_types = function
      []             -> true
    | [_]            -> true
    | ty1 :: ty2 :: tys -> (eq_type ty1 ty2) && (eq_types(ty2 :: tys)) in

  (************************** Convert Exprs **************************)
  
  (* converts expr from AST to SAST form *)
  let rec convert_expr scope e = match e with
    Literal l -> (scope, (Int, SLiteral(l)))
    | BoolLit b -> (scope, (Bool, SBoolLit(b)))
    | CharLit c -> (scope, (Char, SCharLit(c)))
    | StringLit s -> (scope, (String, SStringLit(s)))
    | BinLit b -> 
      (* match on length, assign as bit/nibble/byte/word *)
      (match String.length(b) with 
      | x when x = 1 -> (scope, (Bit, SBitLit(b)))
      | x when x >= 2 && x <= 4 -> (scope, (Nibble, SNibbleLit(b)))
      | x when x >= 5 && x <= 8 -> (scope, (Byte, SByteLit(b)))
      | x when x >= 9 && x <= 16 -> (scope, (Word, SWordLit(b)))
      | x when x = 0 -> raise (InvalidError ("Bin literal too short"))
      | _ -> raise (InvalidError ("Bin literal too long")))
    | Noexpr -> (scope, (Void, SNoexpr))
    | Id s -> 
      (scope, (find_variable scope s, SId s))
    | Binop (e1, op, e2) -> 
        let (scope, (ty1, e1')) = convert_expr scope e1 in
        let (scope, (ty2, e2')) = convert_expr scope e2 in
        let same = eq_type ty1 ty2 in
        let both_bin = is_bin ty1 && is_bin ty2 in
        let ty = match op with
            Add | Sub | Mult | Div when same && ty1 = Int     -> Int
          | Equal | Neq            when same                 -> Bool
          | Less | Leq | Greater | Geq when same && ty1 = Int -> Bool
          | And | Or when same && ty1 = Bool                  -> Bool
          | Binor | Binand | Binxor  when both_bin -> (get_smaller_bin ty1 ty2)
          | Concat when both_bin -> (match (ty1, ty2) with
            (Bit, Bit) -> Nibble
            | (Bit, Nibble) -> Byte 
            | (Bit, Byte) -> Word
            | (Nibble, Bit) -> Byte
            | (Nibble, Nibble) -> Byte
            | (Nibble, Byte) -> Word
            | (Byte, Bit) ->  Word
            | (Byte, Nibble) -> Word
            | (Byte, Byte) -> Word
            | (Word, _) -> Int
            | (_, Word) -> Int
            | _ -> raise (TypeError "Concat only applicatble to Bin types"))
          | Cons -> (match ty2 with
              List ty2' -> if is_primitive_and_not_void ty1 && eq_type ty1 ty2' then List ty1
                            else raise (TypeError ("Cons types " ^ string_of_typ ty1 ^ " and " ^ string_of_typ ty2 ^ " don't match"))
              | _ -> raise (TypeError ("Expecting a list, got " ^ string_of_typ ty2)))
          | Lshift | Rshift when is_bin ty1 && ty2 = Int -> ty1
          | _ -> raise (TypeError ("Types " ^ string_of_typ ty1 ^ " and " ^ string_of_typ ty2 ^ " invalid in Binary operation"))
        in
      (scope, (ty, SBinop((ty1, e1'), op, (ty2, e2'))))
    | Unop (op, e) -> 
        let (scope, (ty1, e')) = convert_expr scope e in
        let ty = (match op with 
          Neg when ty1 = Int -> ty1
          | Binnot when is_bin ty1 -> ty1
          | Not when ty1 = Bool -> Bool
          | Car -> (match ty1 with 
                      List internal_ty -> internal_ty
                       | _ -> raise (TypeError ("expected a list, got " ^ string_of_typ ty1))) 
          | Cdr -> (match ty1 with 
                        List _ -> ty1
                         | _ -> raise (TypeError ("expected a list, got " ^ string_of_typ ty1)))
          | _ -> raise (TypeError ("Type " ^ string_of_typ ty1 ^ " invalid in Unary operation")))
        in
        (scope, (ty, SUnop(op, (ty1, e'))))
    | Assign (var, e)-> 
      let lty = find_variable scope var in
      let (scope, (rty, e')) = convert_expr scope e in
      let _ = eq_type_err lty rty in
      (scope, (lty, SAssign(var, (lty, e'))))
    | Call ("setBit", es) ->
      (* find name in scope, match formals length & type *)
      let call_type = find_variable scope "setBit" in
      let formals = (match call_type with
        Func(formals, _) -> formals
        | _ -> raise (InvalidError (string_of_typ call_type ^ " should be an fdecl")))
      in
        let check_call ft e = 
        let (_, (et, e')) = convert_expr scope e in
        let _ = eq_type_err et ft
        in (et, e')
      in 
      let args' = List.map2 check_call formals es in
      (scope, ((fst (List.hd args')), SCall("setBit", args')))
      | Call ("flipBit", es) ->
        (* find name in scope, match formals length & type *)
        let call_type = find_variable scope "flipBit" in
        let formals = (match call_type with
        Func(formals, _) -> formals
          | _ -> raise (InvalidError (string_of_typ call_type ^ " should be an fdecl")))
        in
          let check_call ft e = 
          let (_, (et, e')) = convert_expr scope e in
          let _ = eq_type_err et ft
          in (et, e')
        in 
        let args' = List.map2 check_call formals es in
        (scope, ((fst (List.hd args')), SCall("flipBit", args')))
    | Call (name, es) -> 
      (* find name in scope, match formals length & type *)
      let call_type = find_variable scope name in
      let (formals, ret) = (match call_type with
        Func(formals, ret) -> (formals, ret)
        | _ -> raise (InvalidError (string_of_typ call_type ^ " should be an fdecl")))
      in
        let check_call ft e = 
        let (_, (et, e')) = convert_expr scope e in
        let _ = eq_type_err et ft in
        let ty = (match et with
          List(Poly) -> if (name = "print" || name = "println") then et else ft
          | _ -> et)
        in (ty, e')
      in 
      let check_list_size l1 l2 = 
        List.length l1 = List.length l2
      in let args' = if check_list_size formals es then 
                     List.map2 check_call formals es else 
                     raise (InvalidError ("wrong number of arugments passed"))
                    in
      (scope, (ret, SCall(name, args')))
    | List es as lst -> 
      match es with
        [] -> (scope, (List(Poly), SList([])))
        | xs ->
          let scope, sexprs = (List.fold_left (fun (curr_scope, sexpr_lst) x -> (let (s, ex) = (convert_expr curr_scope x) in (s, ex:: sexpr_lst))) (scope, []) xs) in
          let tys = List.map fst sexprs in
          if eq_types tys then (scope, (List(List.hd tys), SList(sexprs)))
          else raise (TypeError ("List: " ^ string_of_expr lst ^ " should be a list of the same type"))
  in

  (************************** Checking Variables **************************)

  (* check global variables and add to scope*)
  let check_vdecls (scope, acc) (vdecl: vdecl) = 
    (* extract attributes of vdecl *)
    let typ = vdecl.typ 
    and vname = vdecl.vname 
    and value = vdecl.value in

    (* expr: evaluate expr *)
    let scope, sexpr = convert_expr scope value in

    (* check type equality *) 
    let _ = if (fst sexpr) <> Void then eq_type_err typ (fst sexpr) else true in
    let sexpr = if ((vname != "print" && vname != "println") && (fst sexpr) = List(Poly)) then (typ, snd sexpr) else sexpr in
    
    (* add to scope *)
    let new_var = {
      styp = typ; 
      svname = vname; 
      svalue = sexpr;}
    in
    ((add_decl scope (typ, vname)), new_var :: acc)
  in 

  (************************** Convert Statements **************************)

  (* converts expr e & asserts that it's a bool type *)
  let convert_bool_expr scope e = 
    let (scope, (ty', e')) = convert_expr scope e in
    if ty' == Bool then (scope, (ty', e'))
    else raise (TypeError ("convert_bool_expr: expected Boolean expression in " ^ string_of_expr e)) 
  in

  (* converts stmt from AST to SAST form *)
  let rec convert_stmt scope stmt ret = match stmt with
    Expr(e) -> 
      let (scope, sexpr) = (convert_expr scope e)
      in (scope, SExpr(sexpr), ret)
    | Return(e) -> 
      if ret then raise (ReturnError "Only one return statement for each function is allowed") else
      let (scope, sexpr) = convert_expr scope e in
      (scope, SReturn(sexpr), true)
    | If(e, st1, st2) -> 
      let (scope, sexpr) = convert_bool_expr scope e in
      let (scope, sstmt1, ret) = convert_stmt scope st1 ret in
      let (scope, sstmt2, ret) = convert_stmt scope st2 ret in
      (scope, SIf(sexpr, sstmt1, sstmt2), ret)
    | For(e1, e2, e3, st) -> 
      let (scope, sexpr1) = convert_expr scope e1 in
      let (scope, sexpr2) = convert_bool_expr scope e2 in
      let (scope, sexpr3) = convert_expr scope e3 in
      let (scope, sstmt, ret) = convert_stmt scope st ret in
      (scope, SFor(sexpr1, sexpr2, sexpr3, sstmt), ret)
    | While(e, st) -> 
      let (scope, sexpr) = convert_bool_expr scope e in
      let (scope, sstmt, ret) = convert_stmt scope st ret in
      (scope, SWhile(sexpr, sstmt), ret)
    | Var(vdecl) -> 
      let (scope, lst) = check_vdecls (scope, []) vdecl in
      (scope, SVar(List.hd lst), ret) 
    | Block(sl) -> 
        let new_scope = {
            variables = StringMap.empty;
            parent = Some(scope);
          }
        in
        let rec convert_stmt_list new_scope stmt_list ret = match stmt_list with
          | [Return _ as stmt] ->
              let new_scope, sstmt, ret = convert_stmt new_scope stmt ret in
              (new_scope, [sstmt], ret)
          | Return _ as r :: _ ->
            raise (ReturnError (string_of_stmt r ^ " should not be after a Return statement"))
          | s :: ss ->
              let new_scope, stmt1, ret = convert_stmt new_scope s ret in
              let new_scope, stmt2, ret = convert_stmt_list new_scope ss ret in
              (new_scope, stmt1 :: stmt2, ret)
          | [] -> (new_scope, [], ret)
        in
        let _, stmt_list, ret = convert_stmt_list new_scope sl ret in
        (* return to parent scope *)
        (scope, SBlock stmt_list, ret)
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
    let scope =
      if StringMap.mem fname built_in_funcs 
        then raise (DupError ("built-in function defined with identifier " ^ fname))
      else add_decl scope (Func((List.map fst formals), typ), fname)
    in 

    (* make new scope, parent is scope that was passed in*)
    let new_scope = {variables = StringMap.empty; parent = Some(scope);} in
    
    (* check formals & add to new scope *)
    let new_scope = List.fold_left add_decl new_scope formals in
    
    (* check function body *)
    let _, sstmt_list, _ = convert_stmt new_scope (Block body) false in

    let sstmt_list' = match sstmt_list with
      SBlock(list) -> list
      | _ -> (raise (InvalidError ("Function body should be in a Block")))
    in

    (* check return type of function *)
    let sstmt_list' = List.rev(sstmt_list') in
    let sstmt_list'' = (match typ with
        Void -> (match sstmt_list' with
                SReturn((ret_typ, _))  :: _ -> 
                  let _ = eq_type_err ret_typ Void in sstmt_list'
                | _ -> sstmt_list')
        | _ -> (match sstmt_list' with
              SReturn(ret_typ, exp) :: rest -> 
                let _ = eq_type_err ret_typ typ in
                SReturn(typ, exp) :: rest
              | _ -> (raise (ReturnError ("No return statement found")))))
    in

    (
      scope,
      {
        styp = typ;
        sfname = fname;
        sformals = formals;
        sbody = List.rev(sstmt_list'');
      } :: acc
    )
  in

  (************************** Driver code **************************)

  (* adds built in functions to scope *)
  let scope = {variables = built_in_funcs; parent = None;} in

  (* add global variables to same scope *)
  let scope, globals' = List.fold_left check_vdecls (scope, []) vdecls in

  (* adds user defined functions to scope *)
  let scope, functions' = List.fold_left check_fdecls (scope, []) fdecls in

  (* validate main *)
  let main_fdecl = find_variable scope "main" in
  let _ = match main_fdecl with
    Func([], Int) -> true
    | _ -> raise (InvalidError ("Main function should return an Integer & take no formals"))
  in

(List.rev globals', List.rev functions') 