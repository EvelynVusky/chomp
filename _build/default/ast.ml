(* Abstract Syntax Tree and functions for printing it *)

type op = Add | Sub | Mult | Div | Equal | Neq | Less | Leq | Greater | Geq |
          And | Or | Binnor | Binand | Lshift | Rshift | Concat | Binxor

type uop = Neg | Not | Binnot

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
  | Bit of string
  | Nibble of string
  | Byte of string
  | Word of string

type stmt =
    Block of stmt list
  | Expr of expr
  | Return of expr
  | If of expr * stmt * stmt
  | For of expr * expr * expr * stmt
  | While of expr * stmt

type fdecl = {
    typ : typ;
    fname : string;
    formals : bind list;
    body : stmt list;
  }

type vdecl = {
    typ : typ;
    vname : string;
    value : expr;
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
  | Binnor -> "|"
  | Binand -> "&"
  | Lshift -> "<<"
  | Rshift -> ">>"
  | Concat -> "><"
  | Binxor -> "^"

let string_of_uop = function
    Neg -> "-"
  | Not -> "!"
  | Binnot -> "~"

let rec string_of_expr = function
    Literal(l) -> string_of_int l
  | BoolLit(true) -> "true"
  | BoolLit(false) -> "false"
  | Bit(s) -> "{{" ^ s ^ "}}"
  | Nibble(s) -> "{{" ^ s ^ "}}"
  | Byte(s) -> "{{" ^ s ^ "}}"
  | Word(s) -> "{{" ^ s ^ "}}"
  | CharLit(c) -> "\'" ^ (Char.escaped c) ^ "\'"
  | Id(s) -> s
  | Binop(e1, o, e2) ->
      string_of_expr e1 ^ " " ^ string_of_op o ^ " " ^ string_of_expr e2
  | Unop(o, e) -> string_of_uop o ^ string_of_expr e
  | Assign(v, e) -> v ^ " = " ^ string_of_expr e
  | Call(f, el) ->
      f ^ "(" ^ String.concat ", " (List.map string_of_expr el) ^ ")"
  | Noexpr -> ""
  | List(es) -> "[" ^ String.concat ", " (List.map string_of_expr es) ^ "]"

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

let string_of_vdecl vdecl = string_of_typ vdecl.typ ^ " " ^ vdecl.vname ^ string_of_expr vdecl.value ^ ";\n"

let string_of_fdecl fdecl =
  string_of_typ fdecl.typ ^ " " ^
  fdecl.fname ^ "(" ^ String.concat ", " (List.map snd fdecl.formals) ^
  ")\n{\n" ^
  String.concat "" (List.map string_of_stmt fdecl.body) ^
  "}\n"

let string_of_program program =
  String.concat "" (List.map string_of_vdecl (fst program)) ^ "\n" ^
  String.concat "\n" (List.map string_of_fdecl (snd program))