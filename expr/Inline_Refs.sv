-- with references

grammar expr;

functor attribute inline occurs on Expr, Root;

propagate inline on Root, Expr excluding let_, ref;

inherited attribute to_inline :: Expr occurs on Decl;

aspect production let_
e::Expr ::= d::Decl dexp::Expr body::Expr
{
  e.inline = body.inline;
  d.to_inline = dexp.inline;
}

aspect production ref
e::Expr ::= name::String
{
  e.inline = case lookup( name, e.env) of 
          | just(d) -> d.to_inline
          | _ -> error ("Name " ++ "\"name\"" ++ " not declared.")
          end;
}


