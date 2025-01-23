/* 
 Purpose:
  This program demonstrates the use of Prolog to represent and manipulate 
  complex structures such as points, line segments, triangles, and rectangles 
  in a 2D space. The program explores Prolog's capabilities to:
  - Define and manipulate structures using predicates and functors.
  - Match variables and structures with logical constraints.
  - Use built-in predicates like dif/2 to enforce conditions.
  - Write and test queries for predicates to validate their correctness.

  Features:
  1. Define a set of points (point/2 predicate) in a 2D integer grid that meet specified criteria.
  2. Implement a seg/2 predicate to identify valid line segments between points.
  3. Create a triangle/3 predicate to determine if three points form a valid triangle.
  4. Develop a rectangle/2 predicate to identify valid rectangles formed by vertical segments.
  5. Perform queries to validate each predicate and demonstrate logical reasoning.
*/

% a representation five different points in an X-Y grid of integers.
% exactly two of the points have the same X-value.
% no three points on the same line (no collinear points).
% no two points have the same Y-value.
point(1, 2).
point(1, 4).
point(2, 1).
point(3, 3).
point(4, 6).

% Define seg/2
seg(X, Y) :- 
  point(X1, Y1), point(X2, Y2), % X and Y must be two points
  X = point(X1, Y1),
  Y = point(X2, Y2),
  dif(X, Y). % X and Y must be different

% Define triangle/3
triangle(X,Y,Z):-
  point(X1,Y1), point(X2,Y2), point(X3,Y3), % X, Y, and Z must be three points
  X = point(X1,Y1),
  Y = point(X2,Y2),
  Z = point(X3,Y3),
  dif(X,Y), dif(X,Z), dif(Y,Z). % X, Y, and Z must be different

% Define rectangle/2
% X and Y are both vertical (do not define a vertical predicate)
% The bottom point of X is at the same level as the bottom point of Y
% X and Y are the same length.  Given the above two bullets, this means the top point of X is at the same level as the top point of Y.  Do not actually calculate the length of line segments.

rectangle(X,Y) :- point