#lang racket

;;set
;;seq
;;iif
;;while
;;return 
;;print (2)

;; + - * div mod number id (func 1231)
;; = > < >= <= not and or (can take more than two) true false
;;skip

(define (add val adie) (string->symbol (string-append adie (symbol->string val))))
;;Label Counter
(define lc 0)
;;Compiled
(define compiled empty)
;;If Main exists
(define found_main #f)
;;Function HT
(define funcHT empty)
(struct failure ())
(define opHT #hash((+ . add)
                   (- . sub)
                   (* . mul)
                   (div . div)
                   (mod . mod)
                   (> . gt)
                   (< . lt)
                   (>= . ge)
                   (<= . le)
                   (= . equal)
                   (not . lnot)
                   (and . land)
                   (or . lor)))

(define (add_inst inst) (set! compiled (cons inst compiled)))

(define (create-hash args vars)
  (define ht (make-hash))
  (define counter 2) ;;0 for fp, 1 for pc
  (for [(arg args)]
    (unless (failure? (hash-ref ht arg (failure))) (error "duplicate"))
    (hash-set! ht arg counter)
    (set! counter (+ 1 counter)))
  (for [(var vars)]
    (unless (failure? (hash-ref ht (first var) (failure))) (error "duplicate"))
    (hash-set! ht (first var) counter)
    (add_inst '(add SP SP 1))
    (add_inst (list 'move '(0 SP) (second var)))
    (set! counter (+ 1 counter)))
  (add_inst '(add SP SP 1))
  ht)

(define (check-dupe program)
  (for [(func program)]
    (match func
      [`(fun (,name ,args ...) (vars ,values ,stmts ...) )
       (unless (failure? (hash-ref funcHT name (failure))) (error "duplicate function name"))
       (hash-set! funcHT name (length args))])))

(define (op-trans opd) (hash-ref opHT opd))

(define (exps-eval exp ht)
  (define counter 0)
  (define argCount 0)
  (if (and (list? exp) (failure? (hash-ref opHT (first exp) (failure))))
      (begin
        (add_inst '(move (0 SP) FP))
        (add_inst '(add SP SP 1))
        (for [(arg (rest exp))]
          (add_inst '(add SP SP 1))
          (exps-eval arg ht)
          (set! counter (+ 1 counter)))
        (set! argCount (hash-ref funcHT (first exp) (failure)))
        (when (failure? argCount) (error "undefined function"))
        (unless (= argCount  counter)
          (error (format "arguments given: ~a args: ~a" counter exp)))
        (add_inst (list 'sub 'FP 'SP (+ 1 counter)))
        (add_inst (list 'jsr '(1 FP) (add (first exp) "_"))))
      (match exp
        [`(not ,exp)
         (exps-eval exp ht)
         (add_inst '(lnot (0 SP) (0 SP)))]
        [`(,opd ,arg1 ,arg2)
         (add_inst '(add SP SP 1))
         (exps-eval arg1 ht)
         (add_inst '(add SP SP 1))
         (exps-eval arg2 ht)
         (add_inst '(sub SP SP 2))
         (add_inst (list (op-trans opd) '(0 SP) '(1 SP) '(2 SP)))]
        [`(,opd ,args ...)
         (add_inst (list 'move '(0 SP) (if (symbol=? opd 'and) #t #f)))
         (add_inst '(add SP SP 1))
         (for [(arg args)]
           (exps-eval arg ht)
           (add_inst (list (if (symbol=? opd 'and) 'land 'lor) '(-1 SP) '(0 SP) '(-1 SP))))
         (add_inst '(sub SP SP 1))]
        [(? number? exp) (add_inst (list 'move '(0 SP) exp))]
        [(? boolean? exp) (add_inst (list 'move '(0 SP) exp))]
        [exp
         (define offset (hash-ref ht exp (failure)))
         (when (failure? offset) (error "undefined symbol"))
         (add_inst (list 'move '(0 SP) (list offset 'FP)))])))

(define (cf-h stmts ht)
  (define (inner stmts hasReturn)
    (if (empty? stmts) (void)
        (begin ;;(when (and (empty? stmts) hasReturn) (error "last not return"))
          (when (and hasReturn
                     (empty? (rest stmts))
                     (not (equal? (first (first stmts)) 'return))) (error "last statement not return"))
          (match (first stmts)
            ['(skip) (inner (rest stmts) hasReturn)]
            [`(set ,old ,new) (exps-eval new ht)
                              (add_inst (list 'move (list (hash-ref ht old) 'FP) '(0 SP)))
                              (inner (rest stmts) hasReturn)]
            [`(seq ,Seqstmts ...) (inner Seqstmts #f)
                                  (inner (rest stmts) hasReturn)]
            [`(iif ,cond ,bt ,bf)
             (define prevlc lc)
             (set! lc (+ lc 2))
             (exps-eval cond ht)
             (add_inst (list 'branch '(0 SP) (string->symbol (format "label~a" prevlc))))
             (inner (list bf) #f)
             (add_inst (list 'jump (string->symbol (format "label~a" (+ prevlc 1)))))
             (add_inst (list 'label (string->symbol (format "label~a" prevlc))))
             (inner (list bt) #f)
             (add_inst (list 'label (string->symbol (format "label~a" (+ prevlc 1)))))
             (inner (rest stmts) hasReturn)]
            [`(while ,cond ,body ...)
             (define prevlc lc)
             (set! lc (+ lc 2))
             (add_inst (list 'label (string->symbol (format "label~a" (+ prevlc 1))))) ;;Start
             (exps-eval cond ht)
             (add_inst '(lnot (0 SP) (0 SP))) ;;Negating the res
             (add_inst (list 'branch '(0 SP) (string->symbol (format "label~a" prevlc)))) ;;Jump to end if res is false
             (inner body #f) ;;Evaluate body
             (add_inst (list 'jump (string->symbol (format "label~a" (+ prevlc 1))))) ;;Jump to Top
             (add_inst (list 'label (string->symbol (format "label~a" prevlc)))) ;;END
             (inner (rest stmts) hasReturn)]
            [`(print ,st)
             (if (string? st)
                 (add_inst (list 'print-string st))
                 (begin (exps-eval st ht)
                        (add_inst '(print-val (0 SP)))))
             (inner (rest stmts) hasReturn)]
            [`(return ,exp)
             (exps-eval exp ht)
             (add_inst '(move (2 FP) (0 SP)))
             (add_inst '(move SP FP))
             (add_inst '(move FP (0 FP)))
             (add_inst '(move (0 SP) (2 SP)))
             (add_inst '(jump (1 SP)))
             (inner (rest stmts) hasReturn)]
            [exp (exps-eval exp ht) ;;Not sure if I need it...?
                 (inner (rest stmts) hasReturn)]))))
  (inner stmts #t))

(define (compile-func func)
  (match func
    [`(fun (,name ,args ...) (vars ,values ,stmts ...))
     (when (equal? name 'main) (set! found_main #t) (when (not (empty? args)) (error "main takes no arguments")))
     (add_inst (list 'label (add name "_")))
     (define ht (create-hash args values))
     (cf-h stmts ht)]))

(define (setup program)
  (set! lc 0)
  (set! compiled empty)
  (set! found_main #f)
  (set! funcHT (make-hash))
  (check-dupe program)
  (add_inst '(const SPCONST SP))
  (add_inst '(add SP SPCONST 2))
  (add_inst '(add FP SPCONST 1))
  (add_inst '(move (-1 SP) FP))
  (add_inst '(jsr (0 SP) _main))
  (add_inst '(halt)))

(define (compile-simpl program)
  (setup program)
  (for [(func program)]
    (compile-func func))
  (unless found_main (add_inst '(label _main))
    (add_inst '(halt)))
  (add_inst '(data FP 0))
  (add_inst '(data SP (400 0)))
  (reverse compiled))