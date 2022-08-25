grammar expr ;

terminal IntLit_t /[0-9]+/ ; 

{- Regular expressions that are constant strings may be represented
   using single quotes. -}
terminal Or_t     '||' ; 
terminal And_t    '&&' ; 

terminal LParen_t '(' ;
terminal RParen_t ')' ;

terminal Eq_t     '=' ;


lexer class KEYWORDS;

terminal In_t     'in'      lexer classes { KEYWORDS } ;
terminal Let_t    'let'     lexer classes { KEYWORDS } ;
terminal True_t   'true'    lexer classes { KEYWORDS } ;
terminal False_t  'false'   lexer classes { KEYWORDS } ;

terminal Id_t  /[a-zA-Z][a-zA-Z0-9_]*/  submits to { KEYWORDS };


{- 'ignore' terminals are recognized by the scanner but then discarded
   and not returned to the parser.  This is useful for specifying the
   white-space that may appear between lexical constructs and for
   comments.  
-}

ignore terminal WhiteSpace_t /[\t\r\n\ ]+/  ;
ignore terminal LineComment_P  /[\/][\/].*/  ;

