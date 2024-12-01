;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname n-queens) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
#|
In This Problem, I will solve the famous N-Queens problem.

N-Queens, is a problem where it asks in how many ways can we fill up an N*N chess board with N-Queens
   such that no two queens attack each Other. To Solve this, the problem is split into parts A-B

A) check if two queens are attacking each other
B)check if a solution is valid (no two queens are attacking each other in the board)
C)List of candidates with one more queen that the one given
D)Optimized way of doing C
E) produces all the possible solutions to N-Queen Problem, with no repetition.

|#

;; A Position is a (list Nat Nat)
;;
;; A Candidate is a (listof Position)
;; Requires: No two Positions are the same

;;Helper Function for B, and the helper function below.:
;;(valid-pos? p cand n) checks if p is a valid position in respect to the cand and n.
;;  (borders).
;;Examples:
(check-expect (valid-pos? '(2 3) '((2 2) (3 2)) 4) false)

;;valid-pos?: Position Candidate Nat -> Bool
(define (valid-pos? p cand n)
  (and (>= (- n 1) (first p))
       (<= 0 (first p))
       (>= (- n 1) (second p))
       (<= 0 (second p))
       (foldr (lambda (x rror) (and rror (not (attacking? p x)))) true cand)))

;;Helper Function For C and D.
;;(pos-checker row col cand n) produces a listof candidates which have one more queen and are
;;    valid and are in a specific row (and have a col bigger than or equal to col).
;;Examples:
(check-expect (pos-checker 1 0 '((0 0)) 3) '(((1 2) (0 0))))

;;pos-checker: Nat Nat -> (listof Candidate)
(define (pos-checker row col cand n)
  (cond [(= col n) empty]
        [(valid-pos? (list row col) cand n) (cons (cons (list row col) cand)
                                                  (pos-checker row (add1 col) cand n))]
        [else (pos-checker row (add1 col) cand n)]))

;;
;;Part A)
;;
;;(attacking? p1 p2) checks if queen at p1 is attacking queen at p2.
;;Examples:
(check-expect (attacking? '(0 0) '(0 10)) true)
(check-expect (attacking? '(0 0) '(0 0)) true)
(check-expect (attacking? '(0 0) '(10 0)) true)
(check-expect (attacking? '(0 0) '(10 10)) true)
(check-expect (attacking? '(5 5) '(6 7)) false)

;;attacking?: Position Position -> Bool
(define (attacking? p1 p2)
  (or (= (second p1) (second p2))
      (= (first p1) (first p2))
      (= (abs (- (first p1) (first p2)))
         (abs (- (second p1) (second p2))))))

;;Tests:
(check-expect (attacking? '(5 5) '(0 5)) true)
(check-expect (attacking? '(5 5) '(7 3)) true)
(check-expect (attacking? '(5 5) '(3 7)) true)
(check-expect (attacking? '(5 5) '(7 4)) false)

;;
;;Part B)
;;
;;(valid-cand? cand n) checks if cand is a valid candidate in an n*n chess board.
;;Examples:
(check-expect (valid-cand? empty 5) true)
(check-expect (valid-cand? '((2 2)) 5) true)
(check-expect (valid-cand? '((5 5)) 5) false)
(check-expect (valid-cand? '((7 4)) 5) false)
(check-expect (valid-cand? '((2 2) (3 2)) 5) false)
(check-expect (valid-cand? '((0 0) (3 4) (0 5)) 6) false)
(check-expect (valid-cand? '((0 0) (3 4) (10 3)) 5) false)

;;valid-cand?: Candidate Nat -> Bool
(define (valid-cand? cand n)
  (cond [(empty? cand) true]
        [else (and (valid-pos? (first cand) (rest cand) n)
                   (valid-cand? (rest cand) n))]))

;;Tests:
(check-expect (valid-cand? '((2 2) (3 4)) 5) true)
(check-expect (valid-cand? '((2 2) (7 3)) 5) false)
(check-expect (valid-cand? '((0 0) (3 3) (0 5)) 6) false)
(check-expect (valid-cand? '((0 0) (3 4) (1 5)) 6) true)

;;
;;Part C)
;;
;;(neighbours-naive cand n) produces a listof Candidates which have one more queen and are valid.
;;Examples:
(check-expect (neighbours-naive '((3 3)) 4)
              '(((0 1) (3 3)) ((0 2) (3 3)) ((1 0) (3 3)) ((1 2) (3 3)) ((2 0) (3 3)) ((2 1) (3 3))))
(check-expect (neighbours-naive '((3 3) (0 2)) 4)
              '(((1 0) (3 3) (0 2)) ((2 1) (3 3) (0 2))))
(check-expect (neighbours-naive '((1 0) (3 3) (0 2)) 4) empty)

;;neighbours-naive: Candidate Nat -> (listof Candidate)
(define (neighbours-naive cand n)
  (local [;;(row-checker row) produces a listof candidates which have one more queen and are valid.
          ;;row-checker: Nat -> (listof Candidate)
          (define (row-checker row)
            (cond [(= row n) empty]
                  [else (local [(define res (pos-checker row 0 cand n))]
                          (cond [(empty? res) (row-checker (add1 row))]
                                [else (append res (row-checker (add1 row)))]))]))]
    (row-checker 0)))

;;Tests:
(check-expect (neighbours-naive '((0 0)) 2) empty)
(check-expect (neighbours-naive empty 2) '(((0 0)) ((0 1)) ((1 0)) ((1 1))))

;;
;;Part D)
;;
;;(neighbours-row cand n) produces the possible valid candidates with new positions at the lowest
;;    index row possible.
;;Examples:
(check-expect (neighbours-row '((0 0)) 4) '(((1 2) (0 0)) ((1 3) (0 0))))
(check-expect (neighbours-row '((1 0) (0 2)) 4) '(((2 3) (1 0) (0 2))))
(check-expect (neighbours-row '((1 2) (0 0)) 4) empty)
(check-expect (neighbours-row '((4 4)) 4) empty)

;;neighbours-row: Candidate Nat -> (listof Cnadidate)
(define (neighbours-row cand n)
  (local [;;(row-checker row) produces a listof candidates which have one more queen and are valid.
          ;;row-checker: Nat -> (listof Candidate)
          (define (row-checker row)
            (cond [(= row n) empty]
                  [else (pos-checker row 0 cand n)]))]
    (cond [(empty? cand) (row-checker 0)]
          [else (row-checker (+ 1 (first (first cand))))])))

;;Tests:
(check-expect (neighbours-row '((3 1) (2 3) (1 0) (0 2)) 4) empty)
(check-expect (neighbours-row '((0 0)) 2) empty)
(check-expect (neighbours-row empty 2) '(((0 0)) ((0 1))))

;;
;;Part E)
;;
;;(n-queens n nbr-fun) produces all the possible solution candidates to the probelm N-Queens.
;;Examples:
(check-expect (n-queens 2 neighbours-row) empty)
(check-expect (n-queens 2 neighbours-naive) empty)
(check-expect (n-queens 3 neighbours-row) empty)
(check-expect (n-queens 4 neighbours-naive) '(((3 2) (2 0) (1 3) (0 1))
                                              ((3 1) (2 3) (1 0) (0 2))))
(check-expect (n-queens 5 neighbours-naive) '(((4 3) (3 1) (2 4) (1 2) (0 0))
                                              ((4 2) (3 4) (2 1) (1 3) (0 0))
                                              ((4 4) (3 2) (2 0) (1 3) (0 1))
                                              ((4 3) (3 0) (2 2) (1 4) (0 1))
                                              ((4 4) (3 1) (2 3) (1 0) (0 2))
                                              ((4 0) (3 3) (2 1) (1 4) (0 2))
                                              ((4 1) (3 4) (2 2) (1 0) (0 3))
                                              ((4 0) (3 2) (2 4) (1 1) (0 3))
                                              ((4 2) (3 0) (2 3) (1 1) (0 4))
                                              ((4 1) (3 3) (2 0) (1 2) (0 4))))

;n-queens: Nat (Candidate Nat -> (listof Cnadidate)) -> (listof Candidate)
(define (n-queens n nbr-fun)
  (n-queens/acc n nbr-fun empty))

;;Tests:
(check-expect (n-queens 3 neighbours-naive) empty)
(check-expect (n-queens 4 neighbours-row) '(((3 2) (2 0) (1 3) (0 1))
                                            ((3 1) (2 3) (1 0) (0 2))))
(check-expect (n-queens 5 neighbours-row) '(((4 3) (3 1) (2 4) (1 2) (0 0))
                                            ((4 2) (3 4) (2 1) (1 3) (0 0))
                                            ((4 4) (3 2) (2 0) (1 3) (0 1))
                                            ((4 3) (3 0) (2 2) (1 4) (0 1))
                                            ((4 4) (3 1) (2 3) (1 0) (0 2))
                                            ((4 0) (3 3) (2 1) (1 4) (0 2))
                                            ((4 1) (3 4) (2 2) (1 0) (0 3))
                                            ((4 0) (3 2) (2 4) (1 1) (0 3))
                                            ((4 2) (3 0) (2 3) (1 1) (0 4))
                                            ((4 1) (3 3) (2 0) (1 2) (0 4))))

;;(n-queens/acc n nbr-fun pCand) produces all the possible solution candidates to the probelm
;;   N-Queens starting from pCand.
;;Example:
(check-expect (n-queens/acc 4 neighbours-row empty) '(((3 2) (2 0) (1 3) (0 1))
                                                      ((3 1) (2 3) (1 0) (0 2))))

;;n-queens/acc: Nat (Candidate Nat -> (listof Candidate)) Candidate -> (listof Candidate)
(define (n-queens/acc n nbr-fun pCand)
  (local [(define loC (remove-dup (nbr-fun pCand n)))]
    (cond [(empty? loC) (cond [(= (length pCand) n) (list pCand)]
                              [else empty])]
          [else (n-queens/list n nbr-fun loC)])))

;;(n-queens/list n nbr-fun loC) produces all the possible solution candidates to the probelm
;;   N-Queens starting from loC.
;;Examples:
(check-expect (n-queens/list 4 neighbours-row '(((0 1)) ((0 2)))) '(((3 2) (2 0) (1 3) (0 1))
                                                                    ((3 1) (2 3) (1 0) (0 2))))

;;n-queens/list: Nat (Candidate Nat -> (listof Candidate)) (listof Candidate) -> (listof Candidate)
(define (n-queens/list n nbr-fun loC)
  (cond [(empty? loC) empty]
        [else (append (n-queens/acc n nbr-fun (first loC)) (n-queens/list n nbr-fun (rest loC)))]))

;;(remove-dup loC) remvoes any answer in loC that does not match the row of the first answer.
;;Example:
(check-expect (remove-dup '(((0 0)) ((0 1)) ((1 0)) ((1 1)))) '(((0 0)) ((0 1))))

;;remove-dup: (listof Candidate) -> (listof Candidate)
(define (remove-dup loC)
  (cond [(empty? loC) empty]
        [else (local [(define intended-row (first (first (first loC))))]
                (filter (lambda (x) (= (first (first x)) intended-row)) loC))]))