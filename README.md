# Silver-tutorial

The Google Silver tutorial should cover

- our motivation for using attribute grammars, specifically our
  interest in composable and "analyzable" specifications
  - say something about Knuth in 1968 and that these things continue
    to get a steady, if low-level, amount of interest
  - the ableC slide about composition maybe
  
- Program syntax - concrete to abstract
  - AST - defined by a grammar
  
- semantic information on those tree nodes
  - attributes
  
- equations to determine their value 
- Grammars, attributes, equations - the basics
  - AG evaluation - using the animation slides

- 

1. ASTs


2. In expr_intro, expr attribute evaluation
   - using an environment mapping names to values
   
3. higher order
   - an inlining extension - inline
   - add `inline` to Main.sv in composed
   
4. observe 2 environments
   - inline would have liked to have not done that work
   
5. in expr_extensible, references
   - see second host language - expr
   - add second inlining extension - inline
   
6. forwarding
   - add implication extension
   
7. translation
   - an extension that builds on another one
   - so change regexs to be a pattern in intro example
   
   
