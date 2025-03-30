#lang racket
;This program compiles the SIMPL language from CS146 (Algorithm Design and Data Abstraction (Advanced Version)) to PRIMPL. Check out compiler2 for the advanced version!

;;set
;;seq
;;iif
;;while
;;print (2)
;; + - * div mod number id
;; = > < >= <= not and or (can take more than two) true false
;;skip

(define (add val adie) (string->symbol (string-append adie (symbol->string val))))
;;Label Counter
(define lc 0)
(define compiled empty)

(define (add_inst inst) (set! compiled (cons inst compiled)))

(define (op-trans opd)
  (match opd
    ['+ 'add]
    ['- 'sub]
    ['* 'mul]
    ['div 'div]
    ['mod 'mod]
    ['> 'gt]
    ['< 'lt]
    ['>= 'ge]
    ['<= 'le]
    ['= 'equal]
    ['not 'lnot]
    ['and 'land]
    ['or 'lor]))

(define (val-convert values)
  (cond [(empty? values) '((data SP (5 0)))] ;;Stack Pointer
        [else (cons (list 'data (add (first (first values)) "_") (second (first values)))
                    (val-convert (rest values)))]))

(define (exps-eval exp)
  (match exp
    [`(not ,exp)
     (exps-eval exp)
     (add_inst '(lnot (0 SP)))]
    [`(,opd ,arg1 ,arg2)
     (add_inst '(add SP SP 1))
     (exps-eval arg1)
     (add_inst '(add SP SP 1))
     (exps-eval arg2)
     (add_inst '(sub SP SP 2))
     (add_inst (list (op-trans opd) '(0 SP) '(1 SP) '(2 SP)))]
    [`(,opd ,args ...)
     (add_inst (list 'move '(0 SP) (if (symbol=? opd 'and) #t #f)))
     (add_inst '(add SP SP 1))
     (for [(arg args)]
       (exps-eval arg)
       (add_inst (list (if (symbol=? opd 'and) 'land 'lor) '(-1 SP) '(0 SP) '(-1 SP))))
     (add_inst '(sub SP SP 1))]
    [exp
     (add_inst (list 'move '(0 SP) (if (symbol? exp) (add exp "_") exp)))]))

(define (cs-h stmts)
  (cond [(empty? stmts) (void)]
        [else
         (match (first stmts)
           ['(skip) (cs-h (rest stmts))]
           [`(set ,old ,new) (exps-eval new)
                             (add_inst (list 'move (add old "_") '(0 SP)))
                             (cs-h (rest stmts))]
           [`(seq ,Seqstmts ...)
            (cs-h (append Seqstmts (rest stmts)))]
           [`(iif ,cond ,bt ,bf)
            (define prevlc lc)
            (set! lc (+ lc 2))
            (exps-eval cond)
            (add_inst (list 'branch '(0 SP) (string->symbol (format "label~a" prevlc))))
            (cs-h (list bf))
            (add_inst (list 'jump (string->symbol (format "label~a" (+ prevlc 1)))))
            (add_inst (list 'label (string->symbol (format "label~a" prevlc))))
            (cs-h (list bt))
            (add_inst (list 'label (string->symbol (format "label~a" (+ prevlc 1)))))
            (cs-h (rest stmts))]
           [`(while ,cond ,body ...)
            (define prevlc lc)
            (set! lc (+ lc 2))
            (add_inst (list 'label (string->symbol (format "label~a" (+ prevlc 1))))) ;;Start
            (exps-eval cond)
            (add_inst '(lnot (0 SP) (0 SP))) ;;Negating the res
            (add_inst (list 'branch '(0 SP) (string->symbol (format "label~a" prevlc)))) ;;Jump to end if res is false
            (cs-h body) ;;Evaluate body
            (add_inst (list 'jump (string->symbol (format "label~a" (+ prevlc 1))))) ;;Jump to Top
            (add_inst (list 'label (string->symbol (format "label~a" prevlc)))) ;;End
            (cs-h (rest stmts))]
           [`(print ,st)
            (if (string? st)
                (add_inst (list 'print-string st))
                (begin (exps-eval st)
                       (add_inst '(print-val (0 SP)))))
            (cs-h (rest stmts))]
           [exp (exps-eval exp)
                (cs-h (rest stmts))])]))

(define (compile-simpl exps)
  (set! lc 0)
  (set! compiled empty)
  (add_inst '(const SPCONST SP))
  (add_inst '(move SP SPCONST))
  (add_inst '(add SP SP 1))
  (match exps
    [`(vars ,values ,stmts ...)
     (cs-h stmts)
     (add_inst '(halt))
     (for [(value values)]
       (add_inst (list 'data (add (first value) "_") (second value))))
     (add_inst '(data SP (50 0)))
     (reverse compiled)]))