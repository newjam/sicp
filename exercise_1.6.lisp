
(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
          guess
          (sqrt-iter (improve guess x)
                     x)))

; The problem is that each operand in new-if is evaluated regardless of the presume of the predicate.
; In this case sqrt-iter is called regardless of if the guess is good-enough, causing infinite recursion.

