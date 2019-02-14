
; Exercise 1.35.  Show that the golden ratio phi (section 1.2.2) is a fixed point of the transformation x -> 1 + 1/x, and use this fact to compute phi by means of the fixed-point procedure.

(load "fixed-point.lisp")


; phi satisfies the equation
;   phi^2 = phi + 1
; So by dividing each side by phi,
;   phi = 1 + 1/phi
; So if we define the function f(x) = 1 + 1 / x, then
;   f(phi) = 1 + 1 / phi = phi.
; So phi is a fixed point of f.

(define (phi)
  (define (f x) (+ 1 (/ 1 x)))
  (fixed-point f 1.0)
)


