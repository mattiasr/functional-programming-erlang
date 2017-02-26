% Mattias Ryrlén
% Functional Programming Erlang Assignment
-module(assignment).
-export([perimeter/1, perimeter_test/0, area/1, area_test/0,
  enclose/1, enclose_test/0, bits/1, bits_test/0]).

% Helpers
hypotenuse (X, Y) -> math:sqrt((X*X) + (Y*Y)).

% Shapes assignment
perimeter({circle, {_X, _Y}, R}) -> (R+R)*math:pi();
perimeter({rectangle, {_X, _Y}, H, W}) -> H*2+W*2;
perimeter({triangle, {_X, _Y}, A, B}) -> A+B+hypotenuse(A, B).

perimeter_test() ->
  62.83185307179586 = perimeter({circle, {0,0}, 10}),
  120 = perimeter({rectangle, {0,0}, 20, 40}),
  60 = perimeter({rectangle, {0,0}, 20, 10}),
  52.3606797749979 = perimeter({triangle, {0,0}, 20, 10}),
  34.14213562373095 = perimeter({triangle, {0,0}, 10, 10}),
  true.

area({circle, {_X, _Y}, R}) -> R*R*math:pi();
area({rectangle, {_X, _Y}, H, W}) -> H*W;
area({triangle, {_X, _Y}, A, B}) -> (A*B)/2.

area_test() ->
  300.0 = area({triangle, {0,0}, 20, 30}),
  6.0 = area({triangle, {0,0}, 2, 6}),
  600 = area({rectangle, {0,0}, 20, 30}),
  12 = area({rectangle, {0,0}, 2, 6}),
  314.1592653589793 = area({circle, {0,0}, 10}),
  1256.6370614359173 = area({circle, {0,0}, 20}),
  true.

enclose({circle, {X, Y}, R}) -> {rectangle, {X-R, Y-R}, 2*R, 2*R};
enclose({rectangle, {X, Y}, H, W}) -> {rectangle, {X, Y}, H, W};
% Right angle non-rotated triangle. A = Height, B = Width
enclose({triangle, {X, Y}, A, B}) -> {rectangle, {X, Y}, A, B}.

enclose_test() ->
  {rectangle, {-10, -10}, 20, 20} = enclose({circle, {0,0}, 10}),
  {rectangle, {20, 20}, 40, 40} = enclose({circle, {40,40}, 20}),
  {rectangle, {0, 0}, 20, 30} = enclose({triangle, {0,0}, 20, 30}),
  {rectangle, {0, 0}, 20, 30} = enclose({rectangle, {0,0}, 20, 30}),
  true.

% Summing the bits
bits(N) when N >= 0 -> bits(N, 0).
bits(0, C) -> C;
bits(N, C) -> bits((N band (N-1)), (C+1)).

bits_test() ->
  0 = bits(0),
  1 = bits(1),
  1 = bits(2),
  2 = bits(3),
  3 = bits(7),
  1 = bits(8),
  true.
