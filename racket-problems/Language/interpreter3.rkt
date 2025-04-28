#lang racket
;;This program is similar to interpreter1 and interpreter2. This time it has the ability to use boxes along mutation

(require test-engine/racket-tests)

(struct bin (op fst snd) #:transparent) ; op is a symbol; fst, snd are ASTs.

(struct fun (param body) #:transparent) ; param is a symbol; body is an AST.

(struct app (fn arg) #:transparent) ; fn and arg are ASTs.

(struct seq (fst snd) #:transparent)

(struct newbox (exp) #:transparent)
(struct openbox (exp) #:transparent)
(struct setbox (bexp vexp) #:transparent)

;; An AST is a (union bin fun app).

(struct sub (name val) #:transparent)

;; A substitution is a (sub n v), where n is a symbol and v is a value.
;; An environment (env) is a list of substitutions.
;; A store is a list of substitutions

(struct closure (var body envt) #:transparent)

(struct result (val newstore) #:transparent)

;; A closure is a (closure v bdy env), where
;; v is a symbol, bdy is an AST, and env is a environment.
;; A value is a (union number closure).

;; parse: sexp -> AST

(define (parse sx)
  (match sx
    [`(with ((,nm ,nmd)) ,bdy) (app (fun nm (parse bdy)) (parse nmd))]
    [`(+ ,x ,y) (bin '+ (parse x) (parse y))]
    [`(* ,x ,y) (bin '* (parse x) (parse y))]
    [`(- ,x ,y) (bin '- (parse x) (parse y))]
    [`(/ ,x ,y) (bin '/ (parse x) (parse y))]
    [`(fun (,x) ,bdy) (fun x (parse bdy))]
    [`(seq ,exp1 ,exp2) (seq (parse exp1) (parse exp2))]
    [`(box ,exp) (newbox (parse exp))]
    [`(unbox ,b) (openbox (parse b))]
    [`(setbox ,exp1 ,exp2) (setbox (parse exp1) (parse exp2))]
    [`(,f ,x) (app (parse f) (parse x))]
    [x x]))

; op-trans: symbol -> (number number -> number)
; converts symbolic representation of arithmetic function to actual Racket function
(define (op-trans op)
  (match op
    ['+ +]
    ['* *]
    ['- -]
    ['/ /]))



;; lookup: symbol (Anyof env store) -> value
;; looks up a substitution in al (topmost one)

(define (lookup var al)
  (cond
    [(empty? al) (error 'interp "unbound variable ~a" var)]
    [(equal? var (sub-name (first al))) (sub-val (first al))]
    [else (lookup var (rest al))]))

;; newloc: store -> Int
;; returns a new location for the new item

(define (newloc st)
  (length st))

;; interp: AST env store -> result

(define (interp ast env st)
  (match ast
    [(fun v bdy) (result (closure v bdy env) st)]
    [(app fun-exp arg-exp)
     (match (interp fun-exp env st)
       [(result (closure v bdy cl-env) st2)
        (define newarg (interp arg-exp env st))
        (define nl (newloc (result-newstore newarg)))
        (interp bdy (cons (sub v nl) cl-env) 
                                    (cons (sub nl (result-val newarg))
                                          (result-newstore newarg)))])]
    [(bin op x y)
     (match (interp x env st)
       [(result v1 st2)
        (define res2 (interp y env st2))
        (result ((op-trans op) v1 (result-val res2)) (result-newstore res2))])]
    [(seq exp1 exp2)
     (define res1 (interp exp1 env st))
     (interp exp2 env (result-newstore res1))]
    [(newbox exp)
     (define res (interp exp env st))
     (define nl (newloc (result-newstore res)))
     (result nl (cons (sub nl (result-val res)) (result-newstore res)))]
    [(openbox exp)
     (define res (interp exp env st))
     (result (lookup (result-val res) st) (result-newstore res))]
    [(setbox exp1 exp2)
     (define loc (result-val (interp exp1 env st)))
     (define newval (result-val (interp exp2 env st)))
     (result loc (cons (sub loc newval) st))]
    [x (result
        (if (number? x)
            x
            (lookup (lookup x env) st)) st)]))
             
; completely inadequate tests
#|

(check-expect (parse '((fun (x) (+ x 2)) 24)) ...)


(check-expect (result-val (interp (parse '(with ((f (fun (x) (setbox x 12))))
                                                (with ((x (box 2)))
                                                      (seq (with ((y 3))
                                                                 (f x)) (unbox x))))) empty empty)) 12)

(test)
|#