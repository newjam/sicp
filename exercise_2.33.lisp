; Exercise 2.33.
;
; Fill in the missing expressions to complete the following definitions of some basic list-manipulation operations as accumulations:

(define nil ())

(load "accumulate.lisp")

(define (map p sequence)
  (accumulate (lambda (x y) (cons (p x) y)) nil sequence))

; Example: (map square (list 1 2 3 4 5))

(define (append seq1 seq2)
  (accumulate cons seq2 seq1))

; Example: (append (list 1 2 3 4) (list 5 6 7 8))

(define (length sequence)
  (accumulate (lambda (x y) (+ 1 y))  0 sequence))

; Example: (length (list 1 2 3 4))
