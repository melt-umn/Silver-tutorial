grammar composedIntro ;

imports exprIntro;

parser parse :: Root_c
{
  exprIntro;
  inlineIntro;
}

function main 
IOVal<Integer> ::= largs::[String] ioin::IOToken
{
  return driver (largs, parse, ioin);
}



