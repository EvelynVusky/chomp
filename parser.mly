/* Ocamlyacc parser for MicroC */

%{open Ast%}

%token SEMI LPAREN RPAREN LBRACE RBRACE COMMA PLUS MINUS TIMES DIVIDE ASSIGN
%token NOT EQ NEQ LT LEQ GT GEQ AND OR
%token RETURN IF ELSE FOR WHILE INT BOOL VOID LIST
%token LBRACK RBRACK
%token BINOR BINAND LSHIFT RSHIFT CONCAT BINXOR BINNOT
%token BIT NIBBLE BYTE WORD
%token <string> BINLITERAL 
%token <char> CHARLIT
%token <int> LITERAL
%token <bool> BLIT
%token <string> ID
%token EOF

%start program
%type <Ast.program> program

%nonassoc NOELSE
%nonassoc ELSE
%right ASSIGN
%left OR BINOR BINXOR
%left AND BINAND
%left EQ NEQ
%left LT GT LEQ GEQ
%left PLUS MINUS LSHIFT RSHIFT CONCAT
%left TIMES DIVIDE
%right NOT BINNOT

%%

program:
  decls EOF { $1 }

decls:
   /* nothing */ { ([], [])               }
 | decls vdecl { (($2 :: fst $1), snd $1) } (* how global vars get assigned? *)
 | decls fdecl { (fst $1, ($2 :: snd $1)) }

fdecl:
  typ ID LPAREN formals_opt RPAREN LBRACE stmt_list RBRACE
    { { typ = $1;
        fname = $2;
        formals = List.rev $4;
        (* do we need to track local vars? how to get from stmt? create a list of local vars? *)
        body = List.rev $7 } }

formals_opt:
    /* nothing */ { [] }
  | formal_list   { $1 }

formal_list:
    typ ID                   { [($1,$2)]     }
  | formal_list COMMA typ ID { ($3,$4) :: $1 }

typ:
    INT   { Int   }
  | BOOL  { Bool  }
  | VOID  { Void  }
  | LIST typ { List $2 }

stmt_list:
    /* nothing */  { [] }
  | stmt_list stmt { $2 :: $1 }

stmt:
    expr SEMI                               { Expr $1               }
  | RETURN expr_opt SEMI                    { Return $2             }
  | LBRACE stmt_list RBRACE                 { Block(List.rev $2)    }
  | IF LPAREN expr RPAREN stmt %prec NOELSE { If($3, $5, Block([])) }
  | IF LPAREN expr RPAREN stmt ELSE stmt    { If($3, $5, $7)        }
  | FOR LPAREN expr_opt SEMI expr SEMI expr_opt RPAREN stmt
                                            { For($3, $5, $7, $9)   }
  | WHILE LPAREN expr RPAREN stmt           { While($3, $5)         }
  | vdecl                                   { $1 }

vdecl:
    typ ID SEMI {{
                  typ = $1;
                  vname = $2;
                  value = Noexpr;
                }}
  | typ ID ASSIGN expr SEMI {{
                  typ = $1;
                  vname = $2;
                  value = $4;
                }}

expr_opt:
    /* nothing */ { Noexpr }
  | expr          { $1 }

expr:
    LITERAL          { Literal($1)            }
  | BLIT             { BoolLit($1)            }
  | ID               { Id($1)                 }
  | CHARLIT          { CharLit($1)            }
  | LBRACK l1 = list_fields RBRACK { List (l1) }
  | BINLITERAL       { BinLit ($1)            }
  | BIT              { BinLit ($1)            }
  | NIBBLE           { BinLit ($1)            }
  | BYTE             { BinLit ($1)            }
  | WORD             { BinLit ($1)            }
  | BINNOT expr      { Unop(Binnot, $2)       }
  | expr BINAND expr { Binop($1, Binand, $3)  } 
  | expr LSHIFT expr { Binop($1, Lshift, $3)  }
  | expr RSHIFT expr { Binop($1, Rshift, $3)  }
  | expr CONCAT expr { Binop($1, Concat, $3)  }
  | expr BINXOR expr { Binop($1, Binxor, $3)  }
  | expr BINOR expr  { Binop($1, Binor,  $3)  }
  | expr PLUS   expr { Binop($1, Add,   $3)   }
  | expr MINUS  expr { Binop($1, Sub,   $3)   }
  | expr TIMES  expr { Binop($1, Mult,  $3)   }
  | expr DIVIDE expr { Binop($1, Div,   $3)   }
  | expr EQ     expr { Binop($1, Equal, $3)   }
  | expr NEQ    expr { Binop($1, Neq,   $3)   }
  | expr LT     expr { Binop($1, Less,  $3)   }
  | expr LEQ    expr { Binop($1, Leq,   $3)   }
  | expr GT     expr { Binop($1, Greater, $3) }
  | expr GEQ    expr { Binop($1, Geq,   $3)   }
  | expr AND    expr { Binop($1, And,   $3)   }
  | expr OR     expr { Binop($1, Or,    $3)   }
  | MINUS expr %prec NOT { Unop(Neg, $2)      }
  | NOT expr         { Unop(Not, $2)          }
  | ID ASSIGN expr   { Assign($1, $3)         } //TODO, how to we add assignment to vdecls
  | ID LPAREN args_opt RPAREN { Call($1, $3)  }
  | LPAREN expr RPAREN { $2                   }

list_fields:
    l1 = separated_list(COMMA, expr) { l1 }

args_opt:
  /* nothing */ { [] }
  | args_list  { List.rev $1 }

args_list:
    expr                    { [$1] }
  | args_list COMMA expr { $3 :: $1 }