grammar composed ;

imports expr;

parser parse :: Root_c
{
  expr;
  inline;
  implies;
  translation;
}

function main 
IOVal<Integer> ::= largs::[String] ioin::IOToken
{
  return driver (largs, parse, ioin);
}



