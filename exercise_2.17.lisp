; Exercise 2.17.
; Define a procedure last-pair that returns the list that contains only the last element of a given (nonempty) list:

(define (last-pair xs)
  (if (null? (cdr xs))
      (car xs)
      (last-pair (cdr xs))))

