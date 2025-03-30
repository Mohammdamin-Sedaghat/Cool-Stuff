#lang racket
;; This is an Assembler for a language made by Advanced CS146 class.

(struct psymbol (type value))
;; It saves location for data and label and value for const
(struct failure ())

;;Checks if it's the special case of (data X (nat psymbol-or-value))
(define (data-special-case? lst)
  (and (empty? (rest lst))
       (list? (first lst))
       (not (empty? (rest (first lst))))
       (empty? (rest (rest (first lst))))))

(define (hash-p aprimpl)
  (define hs (make-hash))
  (define counter 0)
  (for [(l (in-list aprimpl))]
    (match l
      [`(const ,ps ,v) (if (failure? (hash-ref hs ps (failure)))
                           (hash-set! hs ps (psymbol 'const v))
                           (error (format "duplicate const: ~a" ps)))]
      [`(label ,ps) (if (failure? (hash-ref hs ps (failure)))
                        (hash-set! hs ps (psymbol 'label counter))
                        (error (format "duplicate label: ~a" ps)))]
      [`(data ,ps ,lst ...) (if (failure? (hash-ref hs ps (failure)))
                                (begin (hash-set! hs ps (psymbol 'data counter))
                                       (set! counter (+ counter
                                                        (if (data-special-case? lst)
                                                            (first (first lst))
                                                            (length lst)))))
                                (error (format "duplicate data: ~a" ps)))]
      [x (set! counter (+ counter 1))]))
  hs)

(define (resolver ht)
  (define (res-indiv visited cur)
    (define res (hash-ref ht (psymbol-value cur) (failure)))
    (cond
      [(failure? res) (error (format "undefined ~a" (psymbol-value cur)))]
      [(symbol? (psymbol-value res)) (if (member (psymbol-value res) visited)
                                         (error "circular")
                                         (begin
                                           (hash-set! ht
                                                      (first visited)
                                                      (psymbol (psymbol-type cur)
                                                               (res-indiv
                                                                (cons (psymbol-value cur) visited)
                                                                res)))
                                           (psymbol-value res)))]
      [else (hash-set! ht (first visited) (psymbol (psymbol-type cur) (psymbol-value res)))
            (psymbol-value res)]))

  (hash-for-each ht (lambda (key v)
                      (when (symbol? (psymbol-value v))
                        (res-indiv (list key) v)))))


(define (removeEx aprimp ht)
  (define (openUp lst rst)
    (foldr (lambda (x y) (cons (target-check x #f) y)) rst lst))
  ;;returns the value of dst either in a list or individually depending on lst?
  (define (target-check dst lst?)
    (match dst
      [(? symbol? v)
       (match (hash-ref ht v (failure))
         [(failure) (error "undefined")]
         [(psymbol 'label x) x]
         [(psymbol _ x) (if lst? (list x) x)])]
      [`(,offset ,inv) (list offset (opd-check inv #f))]
      [x x]))

  ;;Checks if it's data, not label,or PRIMPL value
  ;;   or if const-allowed? if it's a const and returns the value
  (define (opd-check opd const-allowed?)
    (match opd
      [(? symbol? v)
       (match (hash-ref ht v (failure))
         [(failure) (error "undefined")]
         [(psymbol 'label x) (error "label: incorrect position")]
         [(psymbol 'data x) (list x)]
         [(psymbol 'const x) (if const-allowed?
                                 x
                                 (error "incorrect"))])]
      [`(,offset ,inv) (list (opd-check offset #t) (opd-check inv #f))]
      [x x]))
  
  (define (rh aprimp)
    (if (empty? aprimp) empty
        (match (first aprimp)
          [`(const ,a ,v) (rh (rest aprimp))]
          [`(label ,v) (rh (rest aprimp))]
          [`(data ,v ,lst ...)
           (cond
             [(data-special-case? lst)
              (define val (target-check (second (first lst)) #f))
              (openUp (build-list (first (first lst)) (lambda (_) val))
                      (rh (rest aprimp)))]
             [else (openUp lst (rh (rest aprimp)))])]
          ['(halt) (cons 0 (rh (rest aprimp)))]
          [`(,op ,dst ,opd1 ,opd2) (cons (list op (opd-check dst #f) (opd-check opd1 #t)
                                               (opd-check opd2 #t))
                                         (rh (rest aprimp)))]
          [`(lnot ,dst ,opd) (cons (list 'lnot (opd-check dst #f) (opd-check opd #t))
                                   (rh (rest aprimp)))]
          [`(jump ,target) (cons (list 'jump (target-check target #t)) (rh (rest aprimp)))]
          [`(branch ,opd ,target) (cons (list 'branch (opd-check opd #t) (target-check target #t))
                                        (rh (rest aprimp)))]
          [`(move ,dest ,opd) (cons (list 'move (opd-check dest #f) (opd-check opd #t))
                                    (rh (rest aprimp)))]
          [`(print-val ,val) (cons (list 'print-val (opd-check val #t))
                                   (rh (rest aprimp)))]
          [`(print-string ,st) (cons (list 'print-string st)
                                     (rh (rest aprimp)))]
          [x (cons (target-check x #f)
                   (rh (rest aprimp)))])))
  (rh aprimp))

(define (primplify aprimpl)
  (define hash-table (hash-p aprimpl))
  (resolver hash-table)
  (removeEx aprimpl hash-table))