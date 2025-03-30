#lang racket
;; A program made to reverse the effect of compressor to real text.


;; -> void
(define (decompress )
  (decompress/acc empty 0))

;; (listof (list Nat Str)) Nat -> void
(define (decompress/acc usedWordsAL LastIndex)
  (define nc (read-char ))
  (cond [(eof-object? nc) (void)]
        [(char=? nc #\newline) (newline) (decompress/acc usedWordsAL LastIndex)]
        [(char=? nc #\space) (display " ") (decompress/acc usedWordsAL LastIndex)]
        [(char-numeric? nc)
         (checkAL (string->number (list->string (cons nc (read-word)))) usedWordsAL)
         (decompress/acc usedWordsAL LastIndex)]
        [else
         (define word (list->string (cons nc (read-word))))
         (display word)
         (decompress/acc (cons (list LastIndex word) usedWordsAL) (+ 1 LastIndex))]))

;; Str (listof (list Nat Str)) -> void
(define (checkAL num usedWordsAL)
  (cond [(or (empty? usedWordsAL)
             (> num (first (first usedWordsAL)))) (display num)]
        [(= num (first (first usedWordsAL))) (display (second (first usedWordsAL)))]
        [else (checkAL num (rest usedWordsAL))]))

;; -> void
(define (read-word )
  (define nc (peek-char))
  (if (or (char=? #\space nc) (char=? nc #\newline) (eof-object? nc))
      empty (cons (read-char) (read-word))))

(decompress )