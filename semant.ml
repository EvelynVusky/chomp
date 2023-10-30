(* Semantic checking for the MicroC compiler *)

open Ast
open Sast

module StringMap = Map.Make(String)

exception TypeError of string
exception NameNotFound of string
exception DupError of string
exception VoidError of string

type symbol_table = {
  variables: ty StringMap.t;
  parent: symbol_table option;
}

(* Semantic checking of the AST. Returns an SAST if successful,
   throws an exception if something is wrong.

   Check each global variable, then check each function *)

let check (vdecls, fdecls) = 
  (************************** Helper Functions **************************)
  (* add built-in functions *)
  let built_in_funcs = 
    let add_built_in_funcs map (name, fms, ret) = StringMap.add name {
      typ = ret; 
      fname = name;
      formals = fms;
      body = [] } map
    List.fold_left add_built_in_funcs StringMap.empty [
      ("toBit", [(Bin, "x")], Bit);
      ("toCrumb", [(Bin, "x")], Crumb);
      ("toNibble", [(Bin, "x")], Nibble);
      ("toByte", [(Bin, "x")], Byte);
      ("toWord", [(Bin, "x")], Word);
      ("toChar", [(Bin, "x")], Char);
      ("toInt", [(Bin, "x")], Int);
      ("set", [(Bin, "x"), (Int, "y"), (Bit, "z")], Bin);
      ("flipBit", [(Bin, "x"), (Int, "y")], Bin);
      ("getBit", [(Bit, "x"), (Int, "y")], Bin);
      ("print", [(Poly, "x")], Void);
      ("println", [(Poly, "x"), Void]);
    ]
    in
  in

  (* add decls, checks for duplicates, and adds to scope *)
  let add_decl scope (typ, name, value) =
    (* TODO *)
    (* check no variables are void typed *)
  in

  (* finds variable in given scope *)
  let find_variable (scope: symbol_table) name = 
    try
      StringMap.find name scope.variables
    with Not_found -> 
      match scope.parent with 
        Some(parent) -> find_variable parent name
        | _          -> raise (NameNotFound ("unidentified id " ^ name))
  in

  let eq_type ty1 ty2 =
    if ty1 <> ty2 
      then raise (TypeError (string_of_typ ty1 ^ " " ^ string_of_typ ty2))
    else true
  in

  (************************** Convert Exprs **************************)
  
  (* converts expr from AST to SAST form *)
  let expr e = 
    (* TODO *)
  in
  
  (************************** Checking Variables **************************)
  (* check global variables and add to scope*)
  let check_vdecls scope vdecl = 
    (* extract attributes of vdecl *)
    let typ = vdecl.typ in
    let vname = vdecl.vname in
    let value = vdecl.value in
    (* expr: evaluate expr *)
    let (ty_e, val_e) = expr value in
    (* check type equality *)
    let _ = eq_type typ ty_e in
    (* add variable to scope *)
    add_decl scope vdecl
  in
  
  (************************** Checking Functions **************************)
  (* check each function and everything inside of them*)
  let check_fdecls (scope, checked) fdecls = 
  in

  (************************** Driver code **************************)

  (* adds built in functions to scope *)
  let scope = {variables = built_in_funcs, parent = None} in (*TODO: built_in_funcs*)
  
  (* add global variables to same scope *)
  let scope, globals' = List.fold_left check_vdecls scope vdecls in
  
  (* adds user defined functions to scope *)
  let scope, functions' = List.fold_left check_fdecls scope fdecls in

  (* check main *)
  let main = try _ find_variable scope "main" in
  (* TODO: check main type *)
  (List.rev globals', List.rev functions')
