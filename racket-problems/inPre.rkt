#lang racket

;; This program turns the infix notation to prefix notation. I gave some example below

#|
(check-expect (in->pre '(1 + 2 + 3)) '(+ 1 2 3))
(check-expect (in->pre '(1 * 2 + 3)) '(+ (* 1 2) 3))
(check-expect (in->pre '(1 * 2 + 3 * 4)) '(+ (* 1 2) (* 3 4)))
(check-expect (in->pre '(1 + 2 + 3 * 4 * 5 + 6 * 7)) '(+ 1 2 (* 3 4 5) (* 6 7)))
(check-expect (in->pre '((1 + (2 + 3 + 4)) * 5)) '(* (+ 1 (+ 2 3 4)) 5))
(check-expect (in->pre '(1 + ((2)) + x)) '(+ 1 2 x))
(check-error (in->pre '(1 + + 2)) "bad expression")
|#

;;An Expression is one of:
;;  Num
;;  Sym
;;  (listof Expression)

;;in-pre: Expression -> Expression
(define (in->pre exp)
  (cond [(not (list? exp)) exp]
        [(and (len=one? exp) (not (op? (first exp)))) (in->pre (first exp))]
        [(or (empty? exp)
             (empty? (rest exp))
             (empty? (rest (rest exp)))
             (not (op? (second exp)))) (error "bad expression")]
        [(symbol=? (second exp) '+) (cons '+ (add exp))]
        [(symbol=? (second exp) '*) (define res (multi exp empty))
                                    (if (empty? (second res)) (cons '* (first res))
                                        (cons '+ (cons (cons '* (first res)) (add (second res)))))]))
;;add : Expression -> Expression
(define (add exp)
  (cond [(empty? exp) empty]
        [(len=one? exp) (list (check-first (first exp)))]
        [(not (op? (second exp))) (error "bad expression")]
        [(symbol=? (second exp) '+) (cons (check-first (first exp)) (add (rest (rest exp))))]
        [(symbol=? (second exp) '*) (define res (multi exp empty))
                                    (cons (cons '* (first res)) (add (second res)))]))
;;multi: Expression Expression -> (listof Expression Expression)
(define (multi exp acc)
  (cond [(empty? exp) (list (reverse acc) empty)]
        [(len=one? exp) (multi empty (cons (check-first (first exp)) acc))]
        [(not (op? (second exp))) (error "bad expression")]
        [(symbol=? (second exp) '*) (multi (rest (rest exp))
                                           (cons (check-first (first exp)) acc))]
        [(symbol=? (second exp) '+) (list (reverse (cons (check-first (first exp)) acc))
                                          (rest (rest exp)))]))

;;op?: Any -> Bool
(define (op? val)
  (and (symbol? val)
       (or (symbol=? val '+) (symbol=? val '*))))

;;len=one? Any -> Bool
(define (len=one? lst)
  (and (list? lst) (not (empty? lst)) (empty? (rest lst))))

;;check-first: Any -> Any
(define (check-first val)
  (if (op? val) (error "bad expression") (in->pre val)))