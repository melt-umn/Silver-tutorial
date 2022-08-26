grammar expr ;

terminal Implies_t     '=>' ; 

concrete productions e::OrExpr_c
 | e1::OrExpr_c '=>' e2::AndExpr_c
   { e.ast = implies_ (e1.ast, e2.ast); }

production implies_
e::Expr ::= l::Expr r::Expr
{
  e.pp = "(" ++ l.pp ++ " => " ++ r.pp ++ ")";

  forwards to or_ (not_ (l), r);
}

