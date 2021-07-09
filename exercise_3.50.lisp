; Exercise 3.50. Complete the following definition, which generalizes stream-map to allow procedures that take multiple arguments, analogous to map in section 2.2.3, footnote 12.

; (define (stream-map proc . argstreams)
;   (if (<??> (car argstreams))
;       the-empty-stream
;       (<??>
;         (apply proc (map <??> argstreams))
;         (apply stream-map
;                (cons proc (map <??> argstreams))))))

(define (stream-map proc . argstreams)
   (if (empty-stream? (car argstreams))
       the-empty-stream
       (cons-stream
         (apply proc (map head argstreams))
         (apply stream-map
                (cons proc (map tail argstreams))))))


(define (display-line x)
  (newline)
  (display x)
)

(define (display-stream s)
  (stream-for-each display-line s))

(display-stream (stream-map + (stream 1 2 3 4 5) (stream 1 2 3 4 5)))



