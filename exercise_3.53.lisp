
(define (add-streams s1 s2)
  (stream-map + s1 s2))

; Exercise 3.53.  Without running the program, describe the elements of the stream defined by

(define s (cons-stream 1 (add-streams s s)))

; 1
; 2


