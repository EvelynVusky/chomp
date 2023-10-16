(* Abstract Syntax Tree and functions for printing it *)

type op = Add | Sub | Mult | Div | Equal | Neq | Less | Leq | Greater | Geq |
          And | Or | Binor | Binand | Lshift | Rshift | Concat | Binxor | Cons

type uop = Neg | Not | Binnot | Car | Cdr

type typ = Int | Bool | Void | Char | List of typ | Bit | Nibble | Byte | Word

type bind = typ * string

type expr =
    Literal of int
  | BoolLit of bool
  | CharLit of char
  | Id of string
  | Binop of expr * op * expr
  | Unop of uop * expr
  | Assign of string * expr
  | Call of string * expr list
  | List of expr list
  | Noexpr
  | BinLit of string
  | Null
  | Print of expr 
  | PrintLn of expr 

type vdecl = {
  typ : typ;
  vname : string;
  value : expr;
}

type stmt =
    Block of stmt list
  | Expr of expr
  | Return of expr
  | If of expr * stmt * stmt
  | For of expr * expr * expr * stmt
  | While of expr * stmt
  | Var of vdecl

type fdecl = {
    typ : typ;
    fname : string;
    formals : bind list;
    body : stmt list;
  }

type program = vdecl list * fdecl list

(* Pretty-printing functions *)

let string_of_op = function
    Add -> "+"
  | Sub -> "-"
  | Mult -> "*"
  | Div -> "/"
  | Equal -> "=="
  | Neq -> "!="
  | Less -> "<"
  | Leq -> "<="
  | Greater -> ">"
  | Geq -> ">="
  | And -> "&&"
  | Or -> "||"
  | Binor -> "|"
  | Binand -> "&"
  | Lshift -> "<<"
  | Rshift -> ">>"
  | Concat -> "><"
  | Binxor -> "^"
  | Cons -> "::"

let string_of_uop = function
    Neg -> "-"
  | Not -> "!"
  | Binnot -> "~"
  | Car -> "car"
  | Cdr -> "cdr"

let rec string_of_expr = function
    Literal(l) -> string_of_int l
  | BoolLit(true) -> "true"
  | BoolLit(false) -> "false"
  | BinLit(s) -> "{{" ^ s ^ "}}"
  | CharLit(c) -> "\'" ^ (Char.escaped c) ^ "\'"
  | Null -> "Null"
  | Id(s) -> s
  | Binop(e1, o, e2) ->
      string_of_expr e1 ^ " " ^ string_of_op o ^ " " ^ string_of_expr e2
  | Unop(o, e) -> string_of_uop o ^ string_of_expr e
  | Assign(v, e) -> v ^ " = " ^ string_of_expr e
  | Call(f, el) ->
      f ^ "(" ^ String.concat ", " (List.map string_of_expr el) ^ ")"
  | Noexpr -> ""
  | List(es) -> "[" ^ String.concat ", " (List.map string_of_expr es) ^ "]"
  | Print(lst) -> "print " ^ string_of_expr lst
  | PrintLn(lst) -> "println " ^ string_of_expr lst
  
  let rec string_of_typ = function
    Int -> "int"
  | Bool -> "bool"
  | Void -> "void"
  | Char -> "char"
  | List(typ) -> "list " ^ (string_of_typ typ)
  | Bit -> "bit"
  | Nibble -> "nibble"
  | Byte -> "byte"
  | Word -> "word"
  
  let string_of_vdecl (v: vdecl) = 
    string_of_typ v.typ ^ " " ^ v.vname ^ " = " ^ string_of_expr v.value ^ ";\n"

  let rec string_of_stmt = function
    Block(stmts) ->
      "{\n" ^ String.concat "" (List.map string_of_stmt stmts) ^ "}\n"
  | Expr(expr) -> string_of_expr expr ^ ";\n";
  | Return(expr) -> "return " ^ string_of_expr expr ^ ";\n";
  | If(e, s, Block([])) -> "if (" ^ string_of_expr e ^ ")\n" ^ string_of_stmt s
  | If(e, s1, s2) ->  "if (" ^ string_of_expr e ^ ")\n" ^
      string_of_stmt s1 ^ "else\n" ^ string_of_stmt s2
  | For(e1, e2, e3, s) ->
      "for (" ^ string_of_expr e1  ^ " ; " ^ string_of_expr e2 ^ " ; " ^
      string_of_expr e3  ^ ") " ^ string_of_stmt s
  | While(e, s) -> "while (" ^ string_of_expr e ^ ") " ^ string_of_stmt s
  | Var(v) -> "var " ^ string_of_vdecl v
  
let string_of_fdecl (f: fdecl) =
  string_of_typ f.typ ^ " " ^
  f.fname ^ "(" ^ (String.concat ", " (List.map snd f.formals)) ^
  ")\n{\n" ^
  (String.concat "" (List.map string_of_stmt f.body)) ^
  "}\n"

let string_of_program program =
  (String.concat "" (List.map string_of_vdecl (fst program))) 
  ^ "\n" ^
  (String.concat "\n" (List.map string_of_fdecl (snd program)))