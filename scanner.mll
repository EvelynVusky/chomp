{ open Parser }

let digit = ['0' - '9']
let digits = digit+
let bin = ['0' - '1']
let bins = bin+

rule token = parse
  [' ' '\t' '\r' '\n'] { token lexbuf } (* Whitespace *)
| "/*"     { comment lexbuf }           (* Comments *)
| '('      { LPAREN }
| ')'      { RPAREN }
| '{'      { LBRACE }
| '}'      { RBRACE }
| '['      { LBRACK }
| ']'      { RBRACK }
| ';'      { SEMI }
| ','      { COMMA }

(* binary operations *)
| '+'      { PLUS }
| '-'      { MINUS }
| '*'      { TIMES }
| '/'      { DIVIDE }
| '='      { ASSIGN }
| "=="     { EQ }
| "!="     { NEQ }
| '<'      { LT }
| "<="     { LEQ }
| ">"      { GT }
| ">="     { GEQ }
| "&&"     { AND }
| "||"     { OR }
| "!"      { NOT }

(* bin binary operations *)
| "|"      { BINOR }
| "&"      { BINAND }
| "<<"     { LSHIFT }
| ">>"     { RSHIFT }
| "><"     { CONCAT }
| "^"      { BINXOR }
| "~"      { BINNOT }

(* flow control *)
| "if"     { IF }
| "else"   { ELSE }
| "for"    { FOR }
| "while"  { WHILE }
| "return" { RETURN }

(* types *)
| "list"   { LIST }
| "int"    { INT }
| "bool"   { BOOL }
| "void"   { VOID }
| "char"   { CHAR }

(*
  int[]
  list[int]
  list(int)
  list<int>
  list int
 *)

(* literals *)
| "{{" (bins as lxm) "}}"   { BINLITERAL(lxm) } (* Binary literals *)
| '\'' (_ as c) '\''        { CHARLIT(c) }      (* char literal*)
| "true"                    { BLIT(true) }
| "false"                   { BLIT(false) }
| digits as lxm             { LITERAL(int_of_string lxm) }
| ['a'-'z' 'A'-'Z']['a'-'z' 'A'-'Z' '0'-'9' '_']* as lxm { ID(lxm) }
| eof                       { EOF }
| _ as char                 { raise (Failure("illegal character " ^ Char.escaped char)) }

and comment = parse
  "*/" { token lexbuf }
| _    { comment lexbuf }
