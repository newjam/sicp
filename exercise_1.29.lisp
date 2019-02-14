(define (cube x) (* x x x))

(define (identity x) x)

(define (inc k) (+ k 1))

(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

(define (simpsons f a b n)
  (define h (/ (- b a)  n))
  (define (y k) (f (+ a (* k h))))
  (define (term k) (if (even? k) (* 2 (y k)) (* 4 (y k))))
  (* (/ h 3) (+ (y 0) (sum term 0 inc n)))
)

