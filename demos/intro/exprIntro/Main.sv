grammar exprIntro ;

function driver
IOVal<Integer> ::= largs::[String] 
                   lang_parser :: (ParseResult<Root_c> ::= String String)
                   ioin::IOToken
{
  local attribute args :: String;
  args = implode(" ", largs);

  local attribute result :: ParseResult<Root_c>;
  result = lang_parser(args, "<<args>>");

  local attribute r_cst :: Root_c ;
  r_cst = result.parseTree ;

  local attribute r_ast :: Root ;
  r_ast = r_cst.ast ;

  local attribute print_failure :: IOToken;
  print_failure =
    printT("Encountered a parse error:\n" ++ result.parseErrors ++ "\n", ioin);

  return ioval(if result.parseSuccess then allTasks.ioOut else print_failure,
               0);

  local allTasks::Tasks = tasks(args, r_ast);
  allTasks.ioIn = ioin;
  
}

nonterminal Task;
nonterminal Tasks;

synthesized attribute ioOut :: IOToken occurs on Task, Tasks;
inherited attribute ioIn :: IOToken occurs on Task, Tasks;

production tasks
ts::Tasks ::= args::String r::Decorated Root 
{
  production attribute tasks::[Task] with ++;
  tasks := [
    print_args(args),
    pretty_print(r),
    print_value(r)
  ];

 local allTasks :: Task = concatTasks(tasks) ;
 allTasks.ioIn = ts.ioIn;
 ts.ioOut = allTasks.ioOut;
}


production print_args
t::Task ::= args::String
{
 t.ioOut = printT ("\n\nCommand line expression: " ++ args ++ "\n\n", t.ioIn);
}

production pretty_print
t::Task ::= r::Decorated Root
{
 t.ioOut = printT("Pretty print: " ++ r.pp ++ "\n\n", t.ioIn);
}

production print_value
t::Task ::= r::Decorated Root
{
 t.ioOut = printT("Value: " ++ toString(r.val) ++ "\n\n", t.ioIn);
}


abstract production concatTasks
t::Task ::= ts::[Task]
{ t.ioOut = if null(ts) then t.ioIn else rest.ioOut ;

  local first::Task = head(ts) ;
  first.ioIn = t.ioIn ;

  local rest::Task = concatTasks( tail(ts) ) ;
  rest.ioIn = first.ioOut ;
}
