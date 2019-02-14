
(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))


(gcd 206 40)
(gcd 40 (remainder 206 40))
(if (= (remainer 206 40) 0) 40 (gcd (remainder 206 40) (remainder 40 (remainder 206 40))))
(if (= 6 0) 40 (gcd (remainder 206 40) (remainder 40 (remainder 206 40))))
(gcd (remainder 206 40) (remainder 40 (remainder 206 40)))
(if (= (remainder 40 (remainder 206 40)) 0) (remainder 40 (remainder 206 40)))
(if (= (remainder 40 6) 0) (remainder 40 (remainder 206 40)))
(if (= 4 0) (remainder 40 (remainder 206 40)))

; well you get the idea, i missed terms but remainder is calculated more than necesary

