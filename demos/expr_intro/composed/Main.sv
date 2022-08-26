grammar composed ;

imports expr;

parser parse :: Root_c
{
  expr;
}

function main 
IOVal<Integer> ::= largs::[String] ioin::IOToken
{
  return driver (largs, parse, ioin);
}



