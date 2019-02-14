
(load "exercise_2.17.lisp")

(define (reverse xs)
  (if (null? xs)
      (xs)
      (cons (car xs) (reverse (cdr xs)))))

