
(define (stream-enumerate-interval low high)
  (if (> low high)
      the-empty-stream
      (cons-stream
       low
       (stream-enumerate-interval (+ low 1) high))))

(define (display-line x)
  (newline)
  (display ">>> ")
  (display x)
)

(define (show x)
  (display-line x)
  x)

(define x (stream-map show (stream-enumerate-interval 0 10)))
; >>> 0
(stream-ref x 5)
; >>> 1
; >>> 2
; >>> 3
; >>> 4
; >>> 5
(stream-ref x 7)
; >>> 6
; >>> 7

; This actually surprises me.
; Where is the state coming from?
; Isn't a stream still a pure value?
; I suppose the delay actually saves the value and doesn't re-evaluate the expression.

(define p (delay (show 3)))
(force p)
(force p)



