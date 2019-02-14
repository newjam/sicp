
(define (monte-carlo trials experiment)
  (define (iter trials-remaining trials-passed)
    (cond ((= trials-remaining 0)
           (/ trials-passed trials))
          ((experiment)
           (iter (- trials-remaining 1) (+ trials-passed 1)))
          (else
           (iter (- trials-remaining 1) trials-passed))))
  (iter trials 0))

(define (random-in-range low high)
  (let ((range (- high low)))
    (+ low (random range))))

(define (estimate-integral P x1 x2 y1 y2 trials)
  (define (experiment)
    (let ((x (random-in-range x1 x2))
          (y (random-in-range y1 y2)))
     (P x y)
    )
  )
  (let* ((ratio    (monte-carlo trials experiment))
         (area     (* (abs (- x2 x1)) (abs (- y2 y1))))
         (estimate (* area ratio)))
   estimate
  )
)

(define (unit-circle-test x y) (<= (+ (square x) (square y)) 1))

(define (estimate-pi n) (estimate-integral unit-circle-test -1.0 1.0 -1.0 1.0 n))

