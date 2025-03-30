#lang racket
;; This program uses blists and bigits to symbolize how computers implement addition and subtraction with limited space.

;;nat-to-blist: Nat -> (listof Nat)
(define (nat-to-blist n)
  (if (= n 0) empty
      (cons (modulo n 10000) (nat-to-blist (quotient n 10000)))))

;;blist-to-nat: (listof Nat) -> Nat
(define (blist-to-nat blist)
  (if (empty? blist) 0
      (+ (first blist) (* 10000 (blist-to-nat (rest blist))))))

;;add: (listof Nat) (listof Nat) -> (listof Nat)
(define (add blist1 blist2)
  ;;add/acc: (listof Nat) (listof Nat) Nat -> (listof Nat)
  (define (add/acc blist1 blist2 carry)
    (cond [(and (empty? blist1) (empty? blist2))
           (if (zero? carry) empty
               (list carry))]
          [(empty? blist1)
           (define frst (+ carry (first blist2)))
           (if (zero? carry) blist2
               (cons (modulo frst 10000)
                     (add/acc blist1 (rest blist2) (quotient frst 10000))))]
          [(empty? blist2)
           (define frst (+ carry (first blist1)))
           (if (zero? carry) blist1
               (cons (modulo frst 10000)
                     (add/acc (rest blist1) blist2 (quotient frst 10000))))]
          [else
           (define frst (+ carry (first blist1) (first blist2)))
           (cons (modulo frst 10000)
                 (add/acc (rest blist1) (rest blist2) (quotient frst 10000)))]))
  (add/acc blist1 blist2 0))

;;mult: (listof Nat) (listof Nat) -> (listof Nat)
(define (mult blist1 blist2)
  ;;mult/helper: (listof Nat) (listof Nat) -> (listof Nat)
  (define (mult/helper blist1 blist2)
    (cond [(empty? blist1) empty]
          [else (add (singleMult (first blist1) blist2 0)
                     (cons 0 (mult/helper (rest blist1) blist2)))]))
  ;;singleMult: Nat (listof Nat) Nat -> (listof Nat)
  (define (singleMult num blist carry)
    (cond [(empty? blist) (if (zero? carry) empty
                              (cons (modulo carry 10000)
                                    (singleMult num empty (quotient carry 10000))))]
          [else
           (define frst (+ carry (* num (first blist))))
           (cons (modulo frst 10000)
                 (singleMult num (rest blist) (quotient frst 10000)))]))
  (mult/helper blist1 blist2))