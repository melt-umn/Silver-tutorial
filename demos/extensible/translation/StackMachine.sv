grammar translation;

nonterminal Cmd;
synthesized attribute txt::String occurs on Cmd;

production push_cmd
c::Cmd ::= b::Boolean
{ c.txt = "push " ++ toString(b); }

production and_cmd
c::Cmd ::=
{ c.txt = "and"; }

production or_cmd
c::Cmd ::=
{ c.txt = "or"; }

production not_cmd
c::Cmd ::=
{ c.txt = "not"; }

function step 
[Boolean] ::= stack::[Boolean] c::Cmd
{
  return case c, stack of
         | push_cmd(b), _            -> b :: stack
         | and_cmd()  , b1::b2::rest -> (b1 && b2) :: rest
         | or_cmd()   , b1::b2::rest -> (b1 || b2) :: rest
         | not_cmd()  , b::rest      -> (! b) :: rest
         | _, _ -> error("Oops...!")
         end;
}


function run
Boolean ::= code::[Cmd]
{
  return case foldl (step, [], code) of
         | [b] -> b
         | _ -> error("Oops again...!")
         end;
}


