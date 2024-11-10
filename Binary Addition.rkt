;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |Binary Addition|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor mixed-fraction #f #t none #f () #t)))
#|
In this project, I tried to mimic how a computer does addition with natrual numbers. (
   By translating the numbers to binary then back to natrual numbers to show user.)
|#

;;A Boolean is (Anyof 1 0).

;;A Boolean Expression (BExp) BExp is one of:
;;  *Boolean
;;  *OpNode

;;An OpNode is a (list (Anyof 'AND 'OR 'XOR) (listof BExp))

;;(add n1 n2) adds the two numbers n1 and n2.
;;Exampels:
(check-expect (add 1 1) 2)
(check-expect (add 102 21) 123)
(check-expect (add 0 0) 0)

;;add: Nat Nat -> Nat
(define (add n1 n2)
  (bin->nat (add-binary 0 (nat->bin n1) (nat->bin n2)) 0))

;;Tests:
(check-expect (add 0 10) 10)
(check-expect (add 1123123 1989488) 3112611)
(check-expect (add 8 17) 25)

;;(add-binary CI lst1 lst2) prodcues the binary addition of lst1 and lst2.
;;Exampels:
(check-expect (add-binary 0 (list 1 0 1 0) (list 1 1 0 1 0)) (list 0 0 0 0 1))
(check-expect (add-binary 0 (list 0 0 0 1 0) (list 1 0 0 0 1 0)) (list 1 0 0 1 1 0))

;;add-binary: Boolean (listof Boolean) (listof Boolean) -> (listof Boolean)
;;Requires:
;;  To achieve accurate results, put CI as 0 when first initializing the funciton.
(define (add-binary CI lst1 lst2)
  (cond [(empty? lst1) (add-binary/oneside CI lst2)]
        [(empty? lst2) (add-binary/oneside CI lst1)]
        [else (cons (eval (list 'XOR (list CI (first lst1) (first lst2))))
                    (add-binary (eval
                                 (list 'OR (list
                                            (eval (list 'AND (list (first lst1) (first lst2))))
                                            (eval (list 'AND
                                                        (list CI
                                                              (eval (list 'OR (list
                                                                               (first lst1)
                                                                               (first lst2))))))))))
                                (rest lst1) (rest lst2)))]))


;;(add-binary/oneside) calculates the addition of lst, assuming that it has a carry of CI first.
;;Examples:
(check-expect (add-binary/oneside 1 (list 1 0 1 0 1 0)) (list 0 1 1 0 1 0))
(check-expect (add-binary/oneside 1 (list 1 1)) (list 0 0 1))

;;add-binary/oneside: Boolean (listof Boolean) -> (listof Boolean)
(define (add-binary/oneside CI lst)
  (cond [(= 0 CI) lst]
        [(empty? lst) (list CI)]
        [else (cons (eval (list 'XOR (list CI (first lst))))
                    (add-binary/oneside (eval (list 'AND (list CI (first lst))))
                                        (rest lst)))]))

;;(bin->nat loB power) produces the decimal representation of the reversed loB.
;;Examples:
(check-expect (bin->nat (list 1 0 1 0) 0) 5)
(check-expect (bin->nat (list 0 1 0 1 0) 0) 10)
(check-expect (bin->nat (list 0) 0) 0)
(check-expect (bin->nat (list 1 1 1 1 1 0) 0) 31)

;;bin->nat: (listof Boolean) Nat -> Nat
;;Requires:
;;   To achieve accurate results set power equal to 0 when calling the funciton at first.
(define (bin->nat loB power)
  (cond [(empty? loB) 0]
        [else (+ (* (expt 2 power) (first loB))
                 (bin->nat (rest loB) (+ power 1)))]))

;;(nat->bin n) produces the revesed binary representation of the decimal representation of n and
;;   a 0 at the end. (unless it's 0, which is only (list 0))
;;Examples:
(check-expect (nat->bin 5) (list 1 0 1 0))
(check-expect (nat->bin 0) (list 0))
(check-expect (nat->bin 10) (list 0 1 0 1 0))
(check-expect (nat->bin 31) (list 1 1 1 1 1 0))

;;nat->bin: Nat -> (listof Boolean)
(define (nat->bin n)
  (cond [(= n 0) (list 0)]
        [else (cons (remainder n 2) (nat->bin (quotient n 2)))]))

;;Note: From this point onward, these are the funcitons from Q2B.
;;(eval bexp) evaluates the bexp.
;;Examples:
(check-expect (eval 1) 1)
(check-expect (eval 0) 0)
(check-expect (eval (list 'AND (list 1 1 1 1))) 1)
(check-expect (eval (list 'AND (list 1 1 1 1))) 1)
(check-expect (eval (list 'OR (list  0 0 0 1))) 1)
(check-expect (eval (list 'XOR (list 1 1 1 0 0))) 1)
(check-expect (eval (list 'AND (list 1 1 1 0))) 0)

;;eval: BExp -> Boolean
(define (eval bexp)
  (cond [(number? bexp) bexp]
        [(symbol=? (first bexp) 'AND) (eval-opNode/AND (second bexp))]
        [(symbol=? (first bexp) 'OR) (eval-opNode/OR (second bexp))]
        [(symbol=? (first bexp) 'XOR) (eval-opNode/XOR (second bexp) 0)]))


;;(eval-opNode/AND loB) evaluates the listof BExp considering that they are connected with an AND.
;;Examples:
(check-expect (eval-opNode/AND (list 1 1 1 (list 'OR (list 0 0 0)))) 0)

;;eval-opNode/AND: (listof BExp) -> Boolean
(define (eval-opNode/AND loB)
  (cond [(empty? loB) 1]
        [(= 1 (eval (first loB))) (eval-opNode/AND (rest loB))]
        [else 0]))

;;(eval-opNode/OR loB) evaluates the listof BExp considering that they are connected with an OR.
;;Examples:
(check-expect (eval-opNode/OR (list 0 0 0 (list 'XOR (list 1 0 0)))) 1)
(check-expect (eval-opNode/OR (list 0 0 0 (list 'XOR (list 1 0 0)) 1)) 1)

;;eval-opNode/OR: (listof BExp) -> Boolean
(define (eval-opNode/OR loB)
  (cond [(empty? loB) 0]
        [(= 0 (eval (first loB))) (eval-opNode/OR (rest loB))]
        [else 1]))

;;(eval-opNode/XOR loB) evaluates the listof BExp considering that they are connected with an XOR.
;;Examples:
(check-expect (eval-opNode/XOR (list 1 0 1 (list 'OR (list 0 0 0)) (list 'AND (list 1 1 1))) 0) 1)

;;eval-opNode/XOR: (listof BExp) Nat -> Boolean
;;requires: to achieve accurate answer, when function initially called, trueCounter should be set to 0
(define (eval-opNode/XOR loB trueCounter)
  (cond [(empty? loB) (modulo trueCounter 2)]
        [(= 1 (eval (first loB))) (eval-opNode/XOR (rest loB) (+ 1 trueCounter))]
        [else (eval-opNode/XOR (rest loB) trueCounter)]))
