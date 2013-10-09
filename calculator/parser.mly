%{ open Ast %}

%token PLUS MINUS TIMES DIVIDE EOF SEQUENCE ASSIGN
%token <int> LITERAL
%token <int> VARIABLE

%left SEQUENCE
%right ASSIGN
%left PLUS MINUS
%left TIMES DIVIDE

%start expr
%type < Ast.expr> expr

%%

expr:
  expr PLUS   expr { Binop($1, Add, $3) }
| expr MINUS  expr { Binop($1, Sub, $3) }
| expr TIMES  expr { Binop($1, Mul, $3) }
| expr DIVIDE expr { Binop($1, Div, $3) }
| VARIABLE ASSIGN expr { Assign($1, $3) }
| LITERAL          { Lit($1) } 
| VARIABLE { Var($1) }
| expr SEQUENCE expr { Sequence($1, $3)}


