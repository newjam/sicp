; https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-14.html#%_sec_2.1.2

; Consider the problem of representing line segments in a plane. Each segment is represented as a pair of points: a starting point and an ending point. Define a constructor make-segment and selectors start-segment and end-segment that define the representation of segments in terms of points. Furthermore, a point can be represented as a pair of numbers: the x coordinate and the y coordinate. Accordingly, specify a constructor make-point and selectors x-point and y-point that define this representation. Finally, using your selectors and constructors, define a procedure midpoint-segment that takes a line segment as argument and returns its midpoint (the point whose coordinates are the average of the coordinates of the endpoints). 

(define (average x y) (/ (+ x y) 2))

(define (make-segment s e) (cons s e))

(define (start-segment s) (car s))
(define (end-segment s)   (cdr s))

(define (make-point x y) (cons x y))

(define (x-point p) (car p))
(define (y-point p) (cdr p))

(define (midpoint-segment s)
  (define ss (start-segment s))
  (define es (end-segment s))
  (define x1 (x-point ss))
  (define y1 (y-point ss))
  (define x2 (x-point es))
  (define y2 (y-point es))
  (make-point (average x1 x2) (average y1 y2)))

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))

(print-point (midpoint-segment (make-segment (make-point 1 2) (make-point 2 1))))
