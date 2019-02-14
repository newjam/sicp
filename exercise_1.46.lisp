; Exercise 1.46.

(define (iterative-improve good-enough? improve)
  (define (impl guess)
    (if (good-enough? guess)
        (guess)
        (impl (improve guess))
    )
  )
  impl
)

(define tolerance 0.0001)
(define (good-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))

(define (fixed-point f first-guess)
  ((iterative-improve (lambda (x) (good-enough? (f x) x)) f) first-guess)
)

(define (sqrt x)
  (fixed-point (lambda (y) (/ x y)) 1.0)
)

(define (identity x) x)

; (fixed-point id 4)
; ((iterative-improve (lambda (x) (good-enough? (id x) x)) f) 4)

; ((lambda (x)
;   (if ((lambda (x) (good-enough? (id x) x)) x)
;       (x)
;       (...)
; ) 4)

; (if ((lambda (x) (good-enough? (id x) x)) 4)
;  (4)
;  (...)

; (if ((good-enough? (id 4) 4))
;  (4)
;  (...)

; (if ((good-enough? 4 4))
;  (4)
;  (...)


; How is 4 not good-enough?


