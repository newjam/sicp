; recursion_SCHEME.lisp
;
; demonstrates how recursion scemes as presented in
; "Functional Programming with Bananas, Lenses, Envelopes and Barbed Wire"
; might work in scheme.

; The usual suspects
(define (compose f g) (lambda (x) (f (g x))))
(define (constant x) (lambda (y) x))
(define (identity x) x)

; First lets define a product "type", which will just be standard lisp pairs.
; Either way, these are much more descriptive names than cons, car, and cdr.
(define (pair a b) (cons a b))
(define (projectLeft p) (car p))
(define (projectRight p) (cdr p))

; Given functions f : X -> A and g : X -> B
; There is a (unique up to isomorphism??) function (tuple f g) such that
;   compose projectLeft (tuple f g)  = f
;   compose projectRight (tuple f g) = g
; Another way to construct pairs.
(define (tuple f g) (lambda (x) (pair (f x) (g x))))

; Given functions f : A -> A' and g : B -> B'
; We can make a function from A * B -> A' * B'
; which behaves in the expected way.
(define (product-map f g)
  (tuple
    (compose f projectLeft)
    (compose g projectRight)
  )
)

; Sums are implemented by tagging a value with left or right.

(define (injectLeft a)  (pair 'left a))
(define (injectRight b) (pair 'right b))

(define (uncurry f)
  (lambda (p)
    (f
      (projectLeft p)
      (projectRight p)
    )
  )
)

; The fusion law for catamorphisms can be represented in psuedo haskell by
; if
;   f . a = b . map f
; then,
;   f . fold a = fold b

; sum     = cata (select (constant 0) (+))
; squares = map square = cata (select Nil ((Cons . square) + id))


; f : A -> X
; g : B -> X
; (select f g) : A + B -> X
; Apply f if we are looking at something injected from A
; Apply g if we are looking at something from B
; Essentially implements the universal property of co-products.
(define (select f g)
  (lambda (s)
    (cond ((eq? (projectLeft s) 'left)  (f (projectRight s)))
          ((eq? (projectLeft s) 'right) (g (projectRight s)))
          (else (error "type error, not a sum")))))

; f: A -> C
; g: B -> D
; sum-map f g : A + B -> C + D
; Notationally we write f + g.
(define (sum-map f g)
  (select
    (compose injectLeft f)
    (compose injectRight g)))

; With our definition of product and sum, lets define lists
; So a List A = () + A * List A

(define emptyList (injectLeft ()))
(define (consList x xs) (injectRight (pair x xs)))

(define (singleton x) (consList x emptyList))

(define emptyList?
  (select
    (constant #t)
    (constant #f)
  )
)

(define example-list (consList 1 (consList 2 (consList 3 (consList 4 emptyList)))))

; (emptyList? emptyList) ~> #t
; (emptyList? example-list) ~> #f


(define (choice x f g)
  ;(display x)
  ;(newline)
  ((select f g) x)
)

(define (tail xs)
  (choice xs
    (lambda (xs) (error "cant take tail of empty list"))
    projectRight
  )
)

(define (head xs)
  (choice xs
    (lambda (xs) (error "cant take head of empty list"))
    projectLeft
  )
)

(define (uncurry f) (lambda (p) (f (projectLeft p) (projectRight p))))


; Here's how we might implement a fold over a list using primitive recursion.
(define (traditional-foldr z op xs)
  (if (emptyList? xs)
      z
      (op (head xs) (traditional-foldr z op (tail xs)))
  )
)

; listF :  (B -> C) -> 1 + A * B -> 1 + A * C
(define (listF f) (sum-map identity (product-map identity f)))


; exampleAlg : () + integer * integer -> integer
(define exampleAlg (select (constant 0) (uncurry +)))

; (exampleAlg (injectLeft ())) ~> 0
; (exampleAlg (injectRight (pair 2 3))) ~> 5

; Here is a  more convoluted version, using our choice, and product-map combinators
(define (foldr z op xs)
  (choice xs
    (constant z)
    (compose (uncurry op) (product-map identity (lambda (sub) (foldr z op sub))))
  )
)

; catamorphism is a generalization of a fold over an recursive data structure.
(define (catamorphism functor algebra xs)
  (algebra
    ((functor (lambda (sub) (catamorphism functor algebra sub))) xs)
  )
)

; Example: (foldr 0 + example-list)

; Here is foldr implemented as a catamorpism
(define (foldr z op xs)
  (define alg
    (select (constant z)   ; emptylist becomes z
            (uncurry op))) ; consList becomes op
  (catamorphism listF alg xs)
)

(define (list-map f xs)
  (catamorphism listF (sum-map identity (product-map f identity)) xs)
)

(define (list-append xs ys)
  (foldr ys consList xs))

; (foldr 0 + example-list) ~> 10

; To demonstrate the abstraction, let's try this on trees.

; leaf : A -> Tree a
(define leaf injectLeft)
; branch : Tree A, Tree a -> Tree a
(define (branch x y) (injectRight (pair x y)))

; exampleTree : Tree integer
(define example-tree
  (branch
    (leaf 2)
    (branch
      (leaf 1)
      (leaf 4)
    )
  )
)

; treeF : (B -> C) -> A + B * B -> A + C * C
(define (treeF f) (sum-map identity (product-map f f)))

; a, a -> b , Tree a ->
(define (tree-fold op tree)
  (define algebra (select
      identity     ; pull values out of leaves
      (uncurry op) ; apply op to each side of branch
    ))
  (catamorphism treeF algebra tree)
)

(define (inc x) (+ 1 x))

(define (tree-map f tree)
  (catamorphism treeF (sum-map f identity) tree))

(define product-swap (tuple projectRight projectLeft))

; using the notation of lenses (| id + swap |)
(define (tree-swap tree)
  (catamorphism treeF (sum-map identity product-swap) tree))


(define (tree-flatten tree)
  (catamorphism treeF (select singleton (uncurry list-append)) tree))

; Nice! this is basically the same definition as given in "A Tribute to Attributes"
; http://www.kestrel.edu/home/people/meertens/publications/papers/A_tribute_to_attributes.pdf
(define (tree-height tree)
  (catamorphism treeF (select (constant 1) (compose inc (uncurry max))) tree))

(define (tree-size tree)
  (tree-fold + (tree-map (constant 1) tree)))

; (treeFold + exampleTree) ~> 7

