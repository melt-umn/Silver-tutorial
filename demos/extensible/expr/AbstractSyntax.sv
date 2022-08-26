grammar expr ;

nonterminal Root;

synthesized attribute pp :: String;

attribute pp occurs on Root;

synthesized attribute val :: Boolean occurs on Root;
inherited attribute env :: [ (String, Decorated Decl) ] ;

production root
r::Root ::= e::Expr
{
  r.pp = e.pp ;
  r.val = e.val ;
  e.env = [];
}

nonterminal Expr with pp, env, val;

production let_
e::Expr ::= d::Decl dexp::Expr body::Expr
{
  e.pp = "(let " ++ d.name ++ " = " ++ dexp.pp ++ " in " ++ body.pp ++ ")";
  e.val = body.val;
  dexp.env = e.env;
  body.env = (d.name, d) :: e.env;

  d.val_of = dexp.val;
}

nonterminal Decl with name;
synthesized attribute name::String;

inherited attribute val_of :: Boolean occurs on Decl;
production decl
d::Decl ::= name::String
{
  d.name = name;
}

production or_
e::Expr ::= l::Expr r::Expr
{
  e.pp = "(" ++ l.pp ++ " || " ++ r.pp ++ ")";
  e.val = l.val || r.val ;
  l.env = e.env;
  r.env = e.env;
}

production and_
e::Expr ::= l::Expr r::Expr
{
  e.pp = "(" ++ l.pp ++ " && " ++ r.pp ++ ")";
  e.val = l.val && r.val ;
  l.env = e.env;
  r.env = e.env;
}

production not_
e::Expr ::= e1::Expr
{
  e.pp = "(! (" ++ e1.pp ++ "))";
  e.val = ! e1.val ;
  e1.env = e.env;
}

production true_
e::Expr ::=
{
  e.pp = "true";
  e.val = true;
}

production false_
e::Expr ::=
{
  e.pp = "false";
  e.val = false;
}

production ref
e::Expr ::= name::String
{
  e.pp = name;
  e.val = case lookup( name, e.env) of  
          -- | just(v) -> v
          | just(d) -> d.val_of
          | _ -> error ("Name " ++ "\"name\"" ++ " not declared.")
          end;
}

