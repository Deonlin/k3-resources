/K by EXAMPLE
/  K is product of Kx Inc.  http://kx.com
/  2005.06.29. Attila Vrabecz (VrAbi) http://vrabi.web.elte.hu/k
/based on J by EXAMPLE by
/  06/11/2005 (C) Oleg Kobchenko     http://olegykj.sourceforge.net

/simple arithmetic ===============================================

  2+2           /comment is ' /': left of /: whitespace or nothing
                / \+ is verb, Dyad means plus
4
  2-3           /negative numbers
                / \- is verb, Dyad means minus
-1
  2*3+4         /no precedence, right to left
                / \* is verb, Dyad means times
14
  (2*3)+4       /parentheses changes order
10
  3%4           /division represented by '%'
                / % is verb, Dyad means divide
0.75
  _sqr 4        /square, reserved function
16.0
  _sqrt 4       /square root, reserved function
2.0
  %4            /1/x
                / \% is verb, Monad means reciprocal倒數
0.25

/operations using lists ==========================================

  2*1 2 3       /numeric list with space separators
                / \* verb Dyad: times
2 4 6
  1 2 3%2 4 6   /list to list operations, same size
                / \% verb Dyad: divide
0.5 0.5 0.5
  #1 2 3        /size of vector
                / \# verb monad: count
3
  3#1           /generate sequence of same numbers
                / \# verb dyad: take/reshape
1 1 1
  5#1 2         /or from a list of given elements
1 2 1 2 1

/ list elements ===================================================

  *1 2 3        /first element
                / \* verb monad: first
1
  *|1 2 3       /last element
                / |1 2 3, \| verb monad: reverse 
                / *(3;2;1)
3
  1_1 2 3       /rest without first element
                / \_ verb dyad: drop/cut so drop 1 from (1;2;3)
2 3
  -1_1 2 3      /rest without last element, drop -1 from (1;2;3)
1 2
  |1 2 3        /reverse
3 2 1

/ indexing and sorting ============================================

  1 2 3@1       /indexing is zero-based
                / \@ verb dyad: at
2
  1 2 3@1 0     /index can be vector too
2 1
  !3            /generate zero-based sequence
                / \! verb monad: enumerate
0 1 2
  2 4 6?4       /index of given element(s)
                / \? verb dyad: find/invert
1
  <2 1 6        /indices of sorted order ASC
                / \< verb monad: upgrade
1 0 2
  >2 1 6        /indices of sorted order DESC
                / \< verb monad: downgrade
2 0 1
  {x@<x}2 1 6   /sort vector
1 2 6

/ list aggregation ================================================

  1 2 3,10 20     /join vectors
                  / \, verb dyad: join
1 2 3 10 20
  1+2+3           /sum of elements 
                  / \+ dyad: plus
6
  +/1 2 3         /insert '+' between elements
                  / +/ adverb m/ CONVERGE
6
  +\1 2 3         /running sum of elements
                  / +\ adverb m\ CONVERGE
1 3 6        
  1,(1+2),(1+2+3) /same as this or (1;1+2;(1+2)+3)
1 3 6
  1+\2 3          / 1 plus SCAN (2;3)
                  / +\ is adverb d\ SCAN
1 3 6              
  1+/2 3          / 1 plus OVER (2;3)
6
  +\2 3           / but this is (2;2+3)
2 5
  1 2+\:3 4       / is the same as (1+\3 4;2+\3 4)
(1 4 8            / : and ' are always dyadic
 2 5 9)           / \ is optionally dyadic, where the first argument to the monadic 
                  / becomes the left argument to the dyadic
                  / If the monadic is 1 2 3 the first value is 1. So that becomes the left 
                  / argument to the dyadic and the remaining 2 3 becomes the right argument
                  / \: each left means for each argument on the left apply the entire value on the right.
  +':1 2 3 4 5    /sum running pairs
                  
3 5 7 9
  +/'{(2*!-_-.5*#x)_ x}1 2 3 4 5 /non-intersecting pairs
3 7 5
  (1 2;3 4 6;7 6) /list
(1 2
 3 4 6
 7 6)
  *(3 4 6;7 6)    /first item in the list
3 4 6

/ function combinations ===========================================

  {x+_sqr x}4           /a + a^2
20.0
  (_sqrt;_sqr)@\:4      /[sqrt(a), a^2]
2 16.0
  _sqr+/2 3             /(a +b)^2
25.0
  _sqr+\2 3             / a^2 (a+b)^2
4 25.0
  +/_sqr 2 3            /a^2 + b^2
13.0
  {+/(_sqr x),2*/x}2 3  /(a + b)^2 = a^2 + b^2 + 2ab
25.0
   _sqrt+/_sqr 3 4      /sqrt(a^2 + b^2)
5.0

/ user defined functions and arguments ============================

  d1:-          /dyadic projection
  d2:{x-y}      /explicit dyad
  m1:-:         /monadic projection
  m2:0-         /monadic projection
  m3:{-x}       /explicit monad

  (m1;m2;m3)@\:4     / monads
-4 -4 -4
  (d1;d2).\:3 4      / dyads
-1 -1

/ exponent and logarithm ==========================================

  (e;2*e;_sqr e:_exp 1) /e, 2e, e squared
2.718282 5.436564 7.389056
  _exp 2                /exponent, e^2
7.389056
  2^16                  /exponent base 2, 2^16
65536.0
  _log _exp 2           /logarithm, ln e^2
2.0
  _log[65536]%_log[2]   /logarithm base 2, log2 65536
16.0

/ trigonometry ====================================================

  :a:(pi;2*pi;_sqr pi:_acos-1) /pi, 2 pi, pi squared
3.141593 6.283185 9.869604
  _cos pi                      /cosine of pi
-1.0
  (t:+/_sqr(_cos;_sin)@\:)pi   /theorem of trigonometry
1.0
  t a                          /test theorem at angles
1 1 1.0

/ matrices ========================================================

  1 2 3*/:1 2 3 /outer product: multiplication table
(1 2 3
 2 4 6
 3 6 9)
  {x=/:x}@!3    /identity matrix
(1 0 0
 0 1 0
 0 0 1)
  2 3#!6        /generate matrix
(0 1 2
 3 4 5)
  2 2#0 1 1 1   /reshape given vector to matrix
(0 1
 1 1)

/ structural transforms ===========================================

  ,//N:2 2 3#!12             /ravel: list of atoms
0 1 2 3 4 5 6 7 8 9 10 11
  ,/'N                       /ravel each sub-matrix
(0 1 2 3 4 5
6 7 8 9 10 11)
  M:3 3#"ABC123!@#" /character matrix
  (:: ;+: ;|: ;|:'; 1!)@\:M
(("ABC"         / ::  returns argument
  "123"
  "!@#")
 ("A1!"         / +:  transposes
  "B2@"
  "C3#")
 ("!@#"         / |:  reverses items
  "123"
  "ABC")
 ("CBA"         / |:' reverses each items
  "321"
  "#@!")
 ("123"         / 1!  rotates items
  "!@#"
  "ABC"))
  M ./:/:f@=+/'f:,/n,/:\:n:!3  /secondary diagonals
(,"A"
 "B1"
 "C2!"
 "3@"
 ,"#")
  M ./:a,'a:!#M /main diagonal
"A2#"

/ selection ======================================================

   ((N 1) 1) 1 /repetitive selection of items From list
10
   3@[;1]/N    /apply select 3 times
10
   N[1;1;1]    /scatter select
10
   N . 1 1 1   /scatter select too
10

/ factorial and binomial ==========================================

  (f:{:[x<0;0;*/1.+!x]})'1+!5 /factorial
1 2 6 24 120.0
  *\1+!5                      /running product
1 2 6 24 120
  (b:{(!x){:[x<y;0;_ f[x]%f[y]*f x-y]}\:/:!x})5 /binomial coeff.
(1 1 1 1 1
 0 1 2 3 4
 0 0 1 3 6
 0 0 0 1 4
 0 0 0 0 1)
 1_{+/b[x]./:+(!x;|!x)}'!16 /fibonacci: sum of second diagonal of
                             /binomial matrix
1 1 2 3 5 8 13 21 34 55 89 144 233 377 610

/ dot product =====================================================

  1 2 3_dot 1 2 3       /dot product _dot=+/* (optimized)
14
  :M:(0 1;1 1)          /assignment
  :M:(0 1
1 1)                    /equivalent to this
  M _mul M              /matrix squared _mul=_dot\: (optimized)
(1 1
 1 2)
  15_mul[M]/M          /matrix to the power of 15, also fibonacci
(610  987
 987 1597)
  (14_mul[M]\M)[;0;1]
1 1 2 3 5 8 13 21 34 55 89 144 233 377 610

/ randomness and probability ======================================

  :A:5_draw 0          /5 random floats from 0..1
0.03505812 0.7834427 0.7999031 0.9046515 0.2232866
  :B:10_draw 2         /coin toss
1 1 1 0 1 0 1 1 0 0
  :C:3_draw-3          /deal 3 out of 3 cards in certain order
1 0 2
  (&/;|/)@\:A          /min and max over the list
0.03505812 0.9046515
  B?0                  /first zero
3
  {(+/x)%#x}C~/:10000{3_draw-3}\_n  / method monte carlo
0.1643836
  %f 3                 /exact probability of 3 cards in given order
0.1666667

/ unique elements =================================================

  :D:?S:"mississippi" /?: is unique
"misp"
  :K:D?/:S            /find (?) indexes
0 1 2 2 1 2 2 1 3 3 1
  S@=K                /= is group, group by key
(,"m"
 "iiii"
 "ssss"
 "pp")
  #:'=S               /frequencies
1 4 4 2
  :I:(!#S)_lin*:'=S   /sieve of nub
1 1 1 0 0 0 0 0 1 0 0 /where D is in S
  S@&I                /filter by sieve to get D
"misp"
  +/D=/:S             /where items of D are in S
1 4 4 2
