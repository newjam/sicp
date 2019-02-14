; Exercise 3.8.
;
; When we defined the evaluation model in section 1.1.3, we said that the first step in evaluating an expression is to evaluate its subexpressions.
; But we never specified the order in which the subexpressions should be evaluated (e.g., left to right or right to left).
; When we introduce assignment, the order in which the arguments to a procedure are evaluated can make a difference to the result.
; Define a simple procedure f such that evaluating (+ (f 0) (f 1)) will return 0 if the arguments to + are evaluated from left to right but will return 1 if the arguments are evaluated from right to left.

(define previous 0)

(define (f x)
  (let ((r previous))
    (begin
      (set! previous x)
      r
    )
  )
)

; Evaluating the terms we get
;   (f 0) ~> 0
;   (f 1) ~> 0
; However if we reset the interpretter and evaluate the terms in a different order, then
;   (f 1) ~> 0
;   (f 0) ~> 1
; When we evaluate the compound expression, we see
;   (+ (f 0) (f 1)) ~> 1
; So we can conclude the arguments are evaluated from left to right.

(define count 0)

(define (increment-count)
  (set! count (+ count 1))
  count
)

