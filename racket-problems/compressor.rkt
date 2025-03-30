#lang racket
;; Here is a program that uses standard input to compresses it to use numbers instead of words to take up less space. Check out decompresser!

;;read-input: -> (void)
(define (read-input )
  (read-input/acc empty -1) (void))

;;read-input/acc: (listof (list String Int)) Int -> (void)
(define (read-input/acc usedWordsAL lastIndex)
  (define nc (read-char ))
  (cond [(eof-object? nc) (void)]
        [(char=? nc #\newline) (newline) (read-input/acc usedWordsAL lastIndex)]
        [(char=? nc #\space) (display " ") (read-input/acc usedWordsAL lastIndex)]
        [else
         (define res (checkAL (list->string (cons nc (read-word))) usedWordsAL lastIndex))
         (if (false? res) (read-input/acc usedWordsAL lastIndex)
             (read-input/acc res (+ 1 lastIndex)))]))

;;checkAL: String (listof (list String Int)) Int -> (anyof false (listof (list String Int)))
(define (checkAL word usedWordsAL lastIndex)
  (cond [(or (empty? usedWordsAL)
             (string<? word (first (first usedWordsAL))))
         (display word) (cons (list word (+ 1 lastIndex)) usedWordsAL)]
        [(string=? word (first (first usedWordsAL)))
         (display (second (first usedWordsAL))) false]
        [else
         (define res (checkAL word (rest usedWordsAL) lastIndex))
         (if (false? res) false (cons (first usedWordsAL) res))]))

;;read-word: -> (listof Char) 
(define (read-word )
  (define nc (peek-char))
  (if (or (char=? #\space nc) (char=? nc #\newline) (eof-object? nc))
      empty (cons (read-char) (read-word))))

(read-input)