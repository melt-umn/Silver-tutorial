grammar expr ;

parser parse :: Root_c
{
  expr;
}

{--
 - main :: Function( IO ::= String IO ) is the entry point for silver programs.
 -
 - Note that 'IO' is something that should be considered 'the state of the 
 - world' and each value used only once.
 -}
function main 
IOVal<Integer> ::= largs::[String] ioin::IOToken
{
  local attribute args :: String;
  args = implode(" ", largs);

  local attribute result :: ParseResult<Root_c>;
  result = parse(args, "<<args>>");

  local attribute r_cst :: Root_c ;
  r_cst = result.parseTree ;

  local attribute r_ast :: Root ;
  r_ast = r_cst.ast ;

  local attribute print_success :: IOToken;
  print_success = 
    printT( "Command line expression: " ++ args ++
           "\n\n" ++
           "Pretty print: " ++ r_ast.pp ++
           "\n\n" ++
           "Value: " ++ toString(r_ast.val) ++
           "\n\n" ++
           "Inlined: " ++ r_ast.inline.pp ++
           "\n\n"
           , ioin );

  local attribute print_failure :: IOToken;
  print_failure =
    printT("Encountered a parse error:\n" ++ result.parseErrors ++ "\n", ioin);

  return ioval(if result.parseSuccess then print_success else print_failure,
               0);
}



