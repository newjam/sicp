-- From lecture slide "Constructive Algorithmics" By Zhenjiang HU from University of Tokyo.
-- link: http://research.nii.ac.jp/~hu/pub/teach/pm06/CA1.pdf

-- This is an example of using squiggol notation and equational reasoning
-- to validly transform programs into more efficient programs.
-- Here I translate their theorems and programs from squiggol into haskell.


-- The problem is to find the largest sum of segments of a list of integers.
-- So for example in the list [1, 2, -4, 1, 3, -1, 4, -9]
-- The segment with the largest sum is [1, 3, -1, 4] with the sum 7.
-- Let us engage in some wishful thinking and write our solution as
mss = largest . map sum . segments
-- With
largest = foldr max 0
sum     = foldr (+) 0

-- In squiggol this is:
--   ↑/ · +/* · segments

-- The definition of segments is

singleton x = [x]

inits = scanl (++) [] . map singleton

tails = scanr (++) [] . map singleton

tails1 = filter (not . null) . tails -- ie the non empty tails

-- or in squiggol: ++ / . tails * . inits
segments = foldr (++) [] . map tails . inits

-- Note that segments is O(n^2) because
--   inits is O(n) and produces a list O(n) of elements O(n)
--   tails is O(n)
--   so map (tails) . inits is O(n^2)


-- This solution is a little naive.
-- I mean nothing negative about naive:
-- The code is clear and concise and clearly implements a solution to the problem.
-- However, it is quadtratic, and a linear solution exists.

-- The author describes maps and reduces as list homomorphisms.
-- And relates maps and reduces using the following laws

-- Empty Rules
--
--   map f . K [] = K []       Here K is the constant combinator
--   foldr op z . K [] = z
--
-- One-Point Rules
--
--   map f . singleton = singleton . f
--   foldr1 op . singleton = id
--
-- Join Rules
--
--   map f . foldr (++) [] = foldr (++) [] . map (map f)
-- Or in other words
--   map f . concat = concat . map (map f)
-- And the second one:
--   foldr op z . foldr (++) [] = foldr op z . map (foldr op z)

-- The "accumulation lemma" is that
--
--   scanl op e = map (foldr op e) . inits

-- Horner's rule might be familiar to CS students
-- It is used in CLRS and SICP as an example of optimizing an algorithm for evaluating a polynomial.
-- The author here generalizes Horner's rule to any pair of monoids that are distributive.
--
--   foldr1 plus . (map (foldr1 times)) . tails1 = foldr1 odot
--     where a `odot` b = (a `times` b) `plus` b

-- With these laws we can optimize our naive mss'
-- mss' = foldr max 0 . map (foldr (+) 0) . segments
-- Then by the definition of segments
--      = foldr max 0 . map (foldr (+) 0) . foldr1 (++) . map tails . inits
-- Let f = foldr (+) 0, so
--      = foldr max 0 . map f . foldr1 (++) . map tails . inits
-- Then by the first join rule,
--      = foldr max 0 . foldr (++) [] . map (map f) . map tails . inits
-- Then by map distribution
--      = foldr max 0 . foldr (++) [] . map (map f . tails) . inits
-- Then by the second join rule
--      = foldr max 0 . map (foldr max 0) . map (map f . tails) . inits
-- And again by map distribution
--      = foldr max 0 . map (foldr max 0 . map f . tails) . inits
-- Then by substitution
--      = foldr max 0 . map (foldr max 0 . map (foldr (+) 0) . tails) . inits
-- So by our generalized Horner's rule, let a `combine` b = (a + b) `max` b
--      = foldr max 0 . map (foldr combine 0) . inits
-- Then by the accumulation lemma
--      = foldr max 0 . scanl combine 0
-- Which is it!

fastMss = foldlr max 0 . scanl combine 0
  where a `combine` b = (a + b) `max` 0

-- So we've transformed our O(n^2) solution to a O(n) solution by applying
-- transformations that preserve program semantics!
