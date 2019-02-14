
; Implement a representation for rectangles in a plane. (Hint: You may want to make use of exercise 2.2.) In terms of your constructors and selectors, create procedures that compute the perimeter and the area of a given rectangle. Now implement a different representation for rectangles. Can you design your system with suitable abstraction barriers, so that the same perimeter and area procedures will work using either representation?

(load "exercise_2.2.lisp")

(define (make-rectangle top-left bottom-right) (cons top-left bottom-right))

(define (rectangle-top-left r) (car r))
(define (rectangle-bottom-right r) (cdr r))
(define (rectangle-top-right r) (make-point (x-point (rectangle-bottom-right r)) (y-point (rectangle-top-left r))))
(define (rectangle-bottom-left r) (make-point (x-point (rectangle-top-left r)) (y-point (rectangle-bottom-right r))))

(define (length-segment s) (distance-point (start-segment s) (end-segment s)))

(define (distance-point p1 p2)
  (define x1 (x-point p1))
  (define y1 (y-point p1))
  (define x2 (x-point p2))
  (define y2 (y-point p2))
  (sqrt (+ (square (- x2 x1)) (square (- y2 y1)))))

(define (rectangle-top r)    (make-segment (rectangle-top-left r)    (rectangle-top-right r)))
(define (rectangle-bottom r) (make-segment (rectangle-bottom-left r) (rectangle-bottom-right r)))
(define (rectangle-left r)   (make-segment (rectangle-top-left r)    (rectangle-bottom-left r)))
(define (rectangle-right r)  (make-segment (rectangle-top-right r)   (rectangle-bottom-right r)))

(define (rectangle-perimeter r)
  (define top   (rectangle-top r))
  (define right (rectangle-right r))
  (define left  (rectangle-left r))
  (define bottom (rectangle-bottom r))
  (+ (length-segment top) (length-segment bottom) (length-segment right) (length-segment left)))

(define example-rectangle (make-rectangle (make-point 0 0) (make-point 1 2)))

; hmmm in retrospect this doesn't really represent all rectangles, only rectangles whose sides are paralell or perpendicular to the axes.
; TODO!!!

