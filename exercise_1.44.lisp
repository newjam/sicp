; Exercise 1.44

(define (average a b) (/ (+ a b) 2))

(define dx 0.00001)

(define (smooth f)
  (
    lambda (x) (average (f (- x dx)) (f (+ x dx)))
  )
)

(define (f x) (+ x (square x)))
(define g (smooth f))

(load "exercise_1.43.lisp")

(define (n-smooth n f) ((repeated smooth n) f))

(define h (n-smooth 10 f))

