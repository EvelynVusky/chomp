
(* The type of tokens. *)

type token = 
  | WORD
  | WHILE
  | VOID
  | TIMES
  | STRINGLIT of (string)
  | STRING
  | SEMI
  | RSHIFT
  | RPAREN
  | RETURN
  | RBRACK
  | RBRACE
  | PLUS
  | OR
  | NOT
  | NIBBLE
  | NEQ
  | MINUS
  | LT
  | LSHIFT
  | LPAREN
  | LITERAL of (int)
  | LIST
  | LEQ
  | LBRACK
  | LBRACE
  | INT
  | IF
  | ID of (string)
  | GT
  | GEQ
  | FUNC
  | FOR
  | EQ
  | EOF
  | ELSE
  | DIVIDE
  | CONS
  | CONCAT
  | COMMA
  | CHARLIT of (char)
  | CHAR
  | CDR
  | CAR
  | BYTE
  | BOOL
  | BLIT of (bool)
  | BIT
  | BINXOR
  | BINOR
  | BINNOT
  | BINLIT of (string)
  | BINAND
  | ASSIGN
  | AND

(* This exception is raised by the monolithic API functions. *)

exception Error

(* The monolithic API. *)

val program: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Ast.program)
