;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname bexp) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor mixed-fraction #f #t none #f () #t)))
#|
This project tries to mimic how a computer would handle boolean expressions.
There are three parts to this problem:

Part A: If the user only uses booleans, and wants to evaluate the result

Part B: How to present the boolean experession to the user, but with a twist. What if
          the user can also use variables as inputs!

Part C: Now what if the user uses variables which they have dfined and expects to evalute the result.
|#

;;
;;Part A)
;;

;;A Boolean is (Anyof 1 0).

;;A Boolean Expression (BExp) BExp is one of:
;;  *Boolean
;;  *OpNode

;;An OpNode is a (list (Anyof 'AND 'OR 'XOR) (listof BExp))

;;(bexp-template B)...

;; bexp-template: BExp -> Any
(define (bexp-template B)
  (cond [(number? B) (boolean-template B)]
        [else (opnode-template B)]))

;;(opnode-template O)...

;;opnode-template OpNode -> Any
(define (opnode-template O)
  (...(first O)...
      (bexp-template/list (second O))...))

;;(boolean-template B)...

;;boolean-template B: Boolean -> Any
(define (boolean-template B)
  (cond [(= B 0) ...]
        [(= B 1) ...]))

;;(bexp-template/list loB)...

;;bexp-template/list: (listof BExp) -> Any
(define (bexp-template/list loB)
  (cond [(empty? loB) ...]
        [else (...(bexp-template (first loB)) ...
                  (bexp-template/list (rest loB)) ...)]))

;;
;;Part B)
;;
;;(eval bexp) evaluates the bexp.
;;Examples:
(check-expect (eval 1) 1)
(check-expect (eval 0) 0)
(check-expect (eval (list 'AND (list 1 1 1 1))) 1)
(check-expect (eval (list 'AND (list 1 1 1 1))) 1)
(check-expect (eval (list 'OR (list  0 0 0 1))) 1)
(check-expect (eval (list 'XOR (list 1 1 1 0 0))) 1)

;;eval: BExp -> Boolean
(define (eval bexp)
  (cond [(number? bexp) bexp]
        [(symbol=? (first bexp) 'AND) (eval-opNode/AND (second bexp))]
        [(symbol=? (first bexp) 'OR) (eval-opNode/OR (second bexp))]
        [(symbol=? (first bexp) 'XOR) (eval-opNode/XOR (second bexp) 0)]))

;;Tests:
(check-expect (eval (list 'AND (list 1 1 1 0))) 0)
(check-expect (eval (list 'OR (list  0 0 0 0))) 0)
(check-expect (eval (list 'XOR (list 1 1 1 1 0))) 0)
(check-expect (eval (list 'AND (list 1 (list 'AND (list 0 0 1))))) 0)
(check-expect (eval (list 'OR (list  0
                                     (list 'XOR (list 1
                                                      (list 'AND (list 0))))))) 1)

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

;;
;;Part C)
;;
;;A BIDExp is one of:
;;   * Sym
;;   * BExp

;;(bidexp->string bidexp) turns a bidexp to a string for better visualization.
;;Examples:
(check-expect (bidexp->string 1) "t")
(check-expect (bidexp->string 's) "'s")
(check-expect (bidexp->string (list 'AND empty)) "()")
(check-expect (bidexp->string (list 'AND (list 0 0 1 0))) "(f*f*t*f)")

;;bidexp->string: BIDEXP -> Str
(define (bidexp->string bidexp)
  (cond [(symbol? bidexp) (string-append "'" (symbol->string bidexp))]
        [(number? bidexp) (bidexp->string/boolean bidexp)]
        [(symbol=? (first bidexp) 'AND)
         (string-append "(" (bidexp->string/op "*" (second bidexp)) ")")]
        [(symbol=? (first bidexp) 'OR)
         (string-append "(" (bidexp->string/op "+" (second bidexp)) ")")]
        [(symbol=? (first bidexp) 'XOR)
         (string-append "(" (bidexp->string/op "." (second bidexp)) ")")]))

;;Tests:
(check-expect (bidexp->string (list 'OR (list 0 (list 'AND (list 1 0 's 't)) 1 0)))
              "(f+(t*f*'s*'t)+t+f)")
(check-expect (bidexp->string (list 'XOR (list 's 't 1 0))) "('s.'t.t.f)")
(check-expect (bidexp->string (list 'XOR (list 0 (list 'OR (list 1 (list 'AND (list 1 1 1)))))))
              "(f.(t+(t*t*t)))")

;;(bidexp->string/boolean bln) returns "t" for 1, "f" for 0.
;;Examples:
(check-expect (bidexp->string/boolean 1) "t")
(check-expect (bidexp->string/boolean 0) "f")

;;bidexp->string/boolean: Boolean -> Str
(define (bidexp->string/boolean bln)
  (cond [(= 1 bln) "t"]
        [(= 0 bln) "f"]))

;;(bidexp->string/op op loB) returns the string representation of a loB, considering that there is
;;        the op between them.
;;Examples:
(check-expect (bidexp->string/op "+" (list 1 0 (list 'AND (list 0 1)) 1)) "t+f+(f*t)+t")

;;bidexp->string/op: Str (listof BExp) -> Str
(define (bidexp->string/op op loB)
  (cond [(empty? loB) ""]
        [(empty? (rest loB)) (bidexp->string (first loB))]
        [else (string-append (bidexp->string (first loB)) op (bidexp->string/op op (rest loB)))]))


;;
;;Part D)
;;
;;A IdentifierList is (listof (list Sym Boolean))

;;(eval-id bidexp identifier) does the same thing as eval but with identifiers included.
;;Testing Constants:
(define identifier-table (list (list 'x 1) (list 'y 0) (list 'z 1) (list 'X 0)))
;;Examples:
(check-expect (eval-id 1 identifier-table) 1)
(check-expect (eval-id 'x identifier-table) 1)
(check-expect (eval-id (list 'AND empty) identifier-table) 1)
(check-expect (eval-id (list 'AND (list 1 'x 1)) identifier-table) 1)
(check-expect (eval-id (list 'XOR (list 1 'x 'X 'y 0)) identifier-table) 0)
(check-expect (eval-id (list 'XOR (list 1 'x (list 'OR (list 1 'z)) 'y 0)) identifier-table) 1)
(check-expect (eval-id (list 'AND (list 1 'x (list 'AND (list 1 'y)))) identifier-table) 0)

;;eval-id: BIDExp IdentifierList -> Boolean
;;Requires: all the identifiers in bidexp to exist in identifier.
(define (eval-id bidexp identifier)
  (cond [(number? bidexp) bidexp]
        [(symbol? bidexp) (lookup bidexp identifier)]
        [(symbol=? (first bidexp) 'AND) (eval-id-opNode/AND (second bidexp) identifier)]
        [(symbol=? (first bidexp) 'OR) (eval-id-opNode/OR (second bidexp) identifier)]
        [(symbol=? (first bidexp) 'XOR) (eval-id-opNode/XOR (second bidexp) 0 identifier)]))

;;(lookup key AL) returns the value for the key in AL.
;;Examples:
(check-expect (lookup 'X identifier-table) 0)

;;lookup: Sym IdentifierList -> Boolean
;;requires: key to be in AL. and the keys in AL to be unique.
(define (lookup key AL)
  (cond [(symbol=? (first (first AL)) key) (second (first AL))]
        [else (lookup key (rest AL))]))

;;(eval-id-opNode/AND loB) evaluates the listof BExp considering that they are connected with an AND.
;;Examples:
(check-expect (eval-id-opNode/AND (list 1 1 1 (list 'OR (list 0 0 0))) identifier-table) 0)

;;eval-id-opNode/AND: (listof BExp) IdentifierList -> Boolean
;;Requires:
;;   identifiers in loB to be in identifier
(define (eval-id-opNode/AND loB identifier)
  (cond [(empty? loB) 1]
        [(= 1 (eval-id (first loB) identifier)) (eval-id-opNode/AND (rest loB) identifier)]
        [else 0]))

;;(eval-id-opNode/OR loB) evaluates the listof BExp considering that they are connected with an OR.
;;Examples:
(check-expect (eval-id-opNode/OR (list 0 0 0 (list 'XOR (list 1 0 0))) identifier-table) 1)
(check-expect (eval-id-opNode/OR (list 0 0 0 (list 'XOR (list 1 0 0)) 1) identifier-table) 1)
(check-expect (eval-id-opNode/OR empty identifier-table) 0)

;;eval-id-opNode/OR: (listof BExp) IdentifierList-> Boolean
;;Requires:
;;   identifiers in loB to be in identifier
(define (eval-id-opNode/OR loB identifier)
  (cond [(empty? loB) 0]
        [(= 0 (eval-id (first loB) identifier)) (eval-id-opNode/OR (rest loB) identifier)]
        [else 1]))

;;(eval-id-opNode/XOR loB) evaluates the listof BExp considering that they are connected with an XOR.
;;Examples:
(check-expect (eval-id-opNode/XOR (list 1 0 1 (list 'OR (list 0 0 0)) (list 'AND (list 1 1 1)))
                                  0
                                  identifier-table) 1)
(check-expect (eval-id-opNode/XOR empty 0 identifier-table) 0)

;;eval-id-opNode/XOR: (listof BExp) Nat IdentifierList -> Boolean
;;requires:
;;   to achieve accurate answer, when function initially called, trueCounter should be set to 0.
;;   identifiers in loB to be in identifier
(define (eval-id-opNode/XOR loB trueCounter identifier)
  (cond [(empty? loB) (modulo trueCounter 2)]
        [(= 1 (eval-id (first loB) identifier))
         (eval-id-opNode/XOR (rest loB) (+ 1 trueCounter) identifier)]
        [else (eval-id-opNode/XOR (rest loB) trueCounter identifier)]))