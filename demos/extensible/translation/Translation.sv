grammar translation;

import expr;
import inline;

synthesized attribute translation :: [Cmd] occurs on Expr, Root;


aspect production root
r::Root ::= e::Expr
{
  r.translation = e.translation;
}

aspect production let_
e::Expr ::= d::Decl dexp::Expr body::Expr
{
  e.translation = error("Should not compute translation on a let.");
}


aspect production or_
e::Expr ::= l::Expr r::Expr
{
  e.translation = l.translation ++ r.translation ++ [or_cmd()];
}

aspect production and_
e::Expr ::= l::Expr r::Expr
{
  e.translation = l.translation ++ r.translation ++ [and_cmd()];
}

aspect production not_
e::Expr ::= e1::Expr
{
  e.translation = e1.translation ++ [not_cmd()];
}

aspect production true_
e::Expr ::=
{
  e.translation = [ push_cmd(true) ] ;
}

aspect production false_
e::Expr ::=
{
  e.translation = [ push_cmd(false) ] ;
}

aspect production ref
e::Expr ::= name::String
{
  e.translation = error("Should not compute translation on a ref.");
}



aspect production tasks
ts::Tasks ::= args::String r::Decorated Root 
{
  tasks <- [ print_translation(r.inline.translation),
             run_translation(r.inline.translation) 
             ];
}

production print_translation
t::Task ::= code::[Cmd]
{
 local translation :: String = 
      foldl ( (\ t::String c::Cmd -> t ++ c.txt ++ "; "), "", code);
   
 t.ioOut = printT ("Translation: " ++ translation ++ "\n\n", t.ioIn);
}

production run_translation
t::Task ::= code::[Cmd]
{
 local result :: Boolean = run (code);
 t.ioOut = printT ("Value by translation: " ++ toString(result) ++ "\n\n",
                   t.ioIn);
}
