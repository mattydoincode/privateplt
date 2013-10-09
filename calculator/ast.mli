type operator = Add | Sub | Mul | Div

type expr =
    Binop of expr * operator * expr
  | Lit of int
  | Var of int
  | Assign of int * expr
  | Sequence of expr * expr
 