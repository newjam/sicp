(define (dec a) (- a 1))
(define (inc a) (+ a 1))

(define (++ a b)
  (if (= a 0)
      b
      (inc (++ (dec a) b))))

(++ 4 5)

(if (= 4 0)
     5
     (inc (++ (dec 4) 5)))

(if #f
    5
    (inc (++ (dec 4) 5)))

(inc (++ (dec 4) 5))
(inc (++ 3 5))
(inc (inc (++ 2 5)))
(inc (inc (inc (++ 1 5))))
(inc (inc (inc (inc (++ 0 5)))))
(inc (inc (inc (inc 5))))
(inc (inc (inc 6)))
(inc (inc 7))
(inc 8)
9

; (inc ())



