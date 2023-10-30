(* Semantically-checked Abstract Syntax Tree and functions for printing it *)

open Ast

type sexpr = typ * sx
and sx =
    SLiteral of int
  | SBoolLit of bool
  | SCharLit of char
  | SStringLit of string
  | SId of string
  | SBinop of sexpr * op * sexpr
  | SUnop of uop * sexpr
  | SAssign of string * sexpr
  | SCall of string * sexpr list
  | SList of sexpr list
  | SNoexpr
  | SBinLit of string
  | SNull
  | SPrint of sexpr 
  | SPrintLn of sexpr 

type svdecl = {
  styp : typ;
  svname : string;
  svalue : sexpr;
}

type sstmt =
    SBlock of sstmt list
  | SExpr of sexpr
  | SReturn of sexpr
  | SIf of sexpr * sstmt * sstmt
  | SFor of sexpr * sexpr * sexpr * sstmt
  | SWhile of sexpr * sstmt
  | SVar of svdecl

type sfdecl = {
    styp : typ;
    sfname : string;
    sformals : bind list;
    sbody : sstmt list;
  }

type sprogram = svdecl list * sfdecl list

(* Pretty-printing functions *)

let rec string_of_sexpr (t, e) =
  "(" ^ string_of_typ t ^ " : " ^ (match e with
    SLiteral(l) -> string_of_int l
  | SBoolLit(true) -> "true"
  | SBoolLit(false) -> "false"
  | SBinLit(s) -> "{{" ^ s ^ "}}"
  | SCharLit(c) -> "\'" ^ (Char.escaped c) ^ "\'"
  | SStringLit(s) -> "\"" ^ s ^ "\""
  | SNull -> "Null"
  | SId(s) -> s
  | SBinop(e1, o, e2) ->
      string_of_sexpr e1 ^ " " ^ string_of_op o ^ " " ^ string_of_sexpr e2
  | SUnop(o, e) -> string_of_uop o ^ string_of_sexpr e
  | SAssign(v, e) -> v ^ " = " ^ string_of_sexpr e
  | SCall(f, el) ->
      f ^ "(" ^ String.concat ", " (List.map string_of_sexpr el) ^ ")"
  | SNoexpr -> ""
  | SList(es) -> "[" ^ String.concat ", " (List.map string_of_sexpr es) ^ "]"
  | SPrint(lst) -> "print " ^ string_of_sexpr lst
  | SPrintLn(lst) -> "println " ^ string_of_sexpr lst)
  
  let string_of_svdecl (v: svdecl) = 
    string_of_typ v.styp ^ " " ^ v.svname ^ " = " ^ string_of_sexpr v.svalue ^ ";\n"

  let rec string_of_sstmt = function
    SBlock(sstmts) ->
      "{\n" ^ String.concat "" (List.map string_of_sstmt sstmts) ^ "}\n"
  | SExpr(sexpr) -> string_of_sexpr sexpr ^ ";\n";
  | SReturn(sexpr) -> "return " ^ string_of_sexpr sexpr ^ ";\n";
  | SIf(e, s, SBlock([])) -> "if (" ^ string_of_sexpr e ^ ")\n" ^ string_of_sstmt s
  | SIf(e, s1, s2) ->  "if (" ^ string_of_sexpr e ^ ")\n" ^
      string_of_sstmt s1 ^ "else\n" ^ string_of_sstmt s2
  | SFor(e1, e2, e3, s) ->
      "for (" ^ string_of_sexpr e1  ^ " ; " ^ string_of_sexpr e2 ^ " ; " ^
      string_of_sexpr e3  ^ ") " ^ string_of_sstmt s
  | SWhile(e, s) -> "while (" ^ string_of_sexpr e ^ ") " ^ string_of_sstmt s
  | SVar(v) -> "var " ^ string_of_svdecl v
  
let string_of_sfdecl (f: sfdecl) =
  string_of_typ f.styp ^ " " ^
  f.sfname ^ "(" ^ (String.concat ", " (List.map snd f.sformals)) ^
  ")\n{\n" ^
  (String.concat "" (List.map string_of_sstmt f.sbody)) ^
  "}\n"

let string_of_sprogram sprogram =
  (String.concat "" (List.map string_of_svdecl (fst sprogram))) 
  ^ "\n" ^
  (String.concat "\n" (List.map string_of_sfdecl (snd sprogram)))