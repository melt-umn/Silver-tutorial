grammar inline;

import expr;

synthesized attribute inline<a> :: a ;
attribute inline<Expr> occurs on Expr;
attribute inline<Root> occurs on Root;

-- Show this 2nd
-- functor attribute inline occurs on Expr, Root;

inherited attribute to_inline :: [ (String, Expr) ] occurs on Expr;

aspect production root
r::Root ::= e::Expr
{
  r.inline = root(e.inline);
  e.to_inline = [];
}

aspect production let_
e::Expr ::= name::String dexp::Expr body::Expr
{
  e.inline = body.inline;
  dexp.to_inline = e.to_inline;
  body.to_inline = (name, dexp.inline) :: e.to_inline;
}

aspect production or_
e::Expr ::= l::Expr r::Expr
{
  e.inline = or_ (l.inline, r.inline);
  l.to_inline = e.to_inline;
  r.to_inline = e.to_inline;
}
aspect production and_
e::Expr ::= l::Expr r::Expr
{
  propagate to_inline;
  e.inline = and_ (l.inline, r.inline);
--  propagate to_inline, inline;
}
aspect production not_
e::Expr ::= e1::Expr
{
  e.inline = not_ (e1.inline);
  e1.to_inline = e.to_inline;
}
aspect production true_
e::Expr ::=
{
  e.inline = true_();
}
aspect production false_
e::Expr ::=
{
  e.inline = false_();
}
aspect production ref
e::Expr ::= name::String
{
  e.inline = case lookup( name, e.to_inline) of 
          | just(inline_expr) -> inline_expr
          | _ -> error ("Name " ++ "\"name\"" ++ " not declared.")
          end;
}


aspect production tasks
ts::Tasks ::= args::String r::Decorated Root 
{
  tasks <- [ print_inlined(r) ];
}


production print_inlined
t::Task ::= r::Decorated Root
{
 t.ioOut = printT ("Inlined: " ++ r.inline.pp ++ "\n\n", t.ioIn);
}
