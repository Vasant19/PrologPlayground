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