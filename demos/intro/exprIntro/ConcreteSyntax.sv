grammar exprIntro ;

synthesized attribute ast<a> :: a;

-- Root
nonterminal Root_c with ast<Root>;

concrete productions r::Root_c
 | e::LetExpr_c { r.ast = root(e.ast); }

-- Expressions
nonterminal LetExpr_c  with ast<Expr>;
nonterminal OrExpr_c   with ast<Expr>;
nonterminal AndExpr_c  with ast<Expr>;
nonterminal PrimExpr_c with ast<Expr>;

concrete productions e::LetExpr_c
 | 'let' id::Id_t '=' e1::LetExpr_c 'in' e2::LetExpr_c
   { e.ast = let_ (id.lexeme, e1.ast, e2.ast); }

 | e1::OrExpr_c
   { e.ast = e1.ast; }

concrete productions e::OrExpr_c
 | e1::OrExpr_c '||' e2::AndExpr_c
   { e.ast = or_ (e1.ast, e2.ast); }

 | e1::AndExpr_c
   { e.ast = e1.ast; }

concrete productions e::AndExpr_c
 | e1::AndExpr_c '&&' e2::PrimExpr_c 
   { e.ast = and_ (e1.ast, e2.ast); }

 | e1::PrimExpr_c
   { e.ast = e1.ast; }

concrete productions e::PrimExpr_c
 | '!' e1::PrimExpr_c
   { e.ast = not_ (e1.ast); }
 | 'true' 
   { e.ast = true_(); }
 | 'false'
   { e.ast = false_(); }
 | '(' e1::LetExpr_c ')'
   { e.ast = e1.ast; }
 | id::Id_t
   { e.ast = ref(id.lexeme); }

