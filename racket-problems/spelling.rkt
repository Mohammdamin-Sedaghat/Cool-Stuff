;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname spelling) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor mixed-fraction #f #t none #f () #t)))
#|
This project is meant to mimic spell checkers.

So lets assume that spell checkers use trees to track if the word is an existing english word.
In this case, you can check by tracking the nodes and checking if the word terminates at those
nodes.

Part A: structure definitions and templates

Part B:how to first create a tree from a set of existing words

Part C: How to check if a word is an existing word or not from a dictionary.

|#

;;
;;Part A)
;;

(define-struct node (val term? next))
;;A Node is A (make-node Char Bool Next)
;;Requires: val to be upercase char.

;;A Next is a (listof node).
;; where the nodes in next are sorted alphabetically (from A-Z).

;;(node-template n)...

;;node-template: Node -> Any
(define (node-template n)
  (.. (node-val n)
      (node-term? n)
      (next-template (node-next n))))


;;(next-template n)...

;;next-template Next -> Any
(define (next-template n)
  (cond [(empty? n) ...]
        [else (... (node-template (first n))
                   (next-template (rest n)))]))

;;
;;Part B)
;;
;;(create-tree loW) returns the node that acts as the root-node of the tree for the loW.
;;Examples:
(check-expect (create-tree empty) (make-node #\space false empty))
(check-expect (create-tree (list "fun"))
              (make-node #\space false
                         (list (make-node #\F false
                                          (list (make-node #\U false
                                                           (list (make-node #\N true empty))))))))
(check-expect (create-tree (list "fun" "fu"))
              (make-node #\space false
                         (list (make-node #\F false
                                          (list (make-node #\U true
                                                           (list (make-node #\N true empty))))))))
(check-expect (create-tree (list "fun" "fat"))
              (make-node #\space false
                         (list (make-node #\F false
                                          (list (make-node #\A false
                                                           (list (make-node #\T true empty)))
                                                (make-node #\U false
                                                           (list (make-node #\N true empty))))))))

;;create-tree: (listof Str) -> Node
(define (create-tree loW)
  (create-tree/inserter (make-node #\space false empty) loW))

;;Tests:
(check-expect
 (create-tree (list "fun" "fat" "faty"))
 (make-node #\space false
            (list (make-node #\F false
                             (list (make-node #\A false
                                              (list (make-node #\T true
                                                               (list (make-node #\Y true empty))
                                                               )))
                                   (make-node #\U false
                                              (list (make-node #\N true empty))))))))
(check-expect (create-tree (list "sad" "fun"))
              (make-node #\space false
                         (list (make-node #\F false
                                          (list (make-node #\U false
                                                           (list (make-node #\N true empty)))))
                               (make-node #\S false
                                          (list (make-node #\A false
                                                           (list (make-node #\D true empty))))))))
(check-expect (create-tree (list "sAd" "saS"))
              (make-node #\space false
                         (list (make-node #\S false
                                          (list (make-node #\A false
                                                           (list (make-node #\D true empty)
                                                                 (make-node #\S true empty))))))))

;;(create-tree/inserter root loW) produces the node that acts as the root for the loW tree.
;;Examples:
(check-expect (create-tree/inserter (make-node #\space false empty) (list "A" "Ac" "bB"))
              (make-node #\space false (list
                                        (make-node #\A true (list (make-node #\C true empty)))
                                        (make-node #\B false (list (make-node #\B true empty))))))

;;create-tree/inserter: Node (listof Str) -> Node
(define (create-tree/inserter root loW)
  (cond [(empty? loW) root]
        [else (create-tree/inserter
               (make-node (node-val root)
                          (node-term? root)
                          (create-tree/next (node-next root)
                                            (string->list (string-upcase (first loW)))))
               (rest loW))]))

;;(create-tree/next prevNext loC) returns the next after adding the letter in form of loC to prevNext.
;;Examples:
(check-expect (create-tree/next (list (make-node #\A true empty)) (list #\A #\B #\C))
              (list (make-node #\A true (list
                                         (make-node #\B false (list
                                                               (make-node #\C true empty)))))))


;;create-tree/next: Next (listof Char) -> Next
;;Requires:
;;   loC to be non empty
;;   memebers of loC to be upercase letters.
(define (create-tree/next prevNext loC)
  (cond [(or (empty? prevNext) (char<? (first loC) (node-val (first prevNext))))
         (cons (create-node empty loC) prevNext)]
        [(char=? (node-val (first prevNext)) (first loC))
         (cons (create-node  (first prevNext) loC) (rest prevNext))]
        [else (cons (first prevNext) (create-tree/next (rest prevNext) loC))]))

;;(create-node prevNode loC) produces a new node after adding the loC
;;Examples:
(check-expect (create-node (make-node #\A false (list (make-node #\B true empty)))
                           (list #\A #\C #\D))
              (make-node #\A false (list (make-node #\B true empty)
                                         (make-node #\C false (list (make-node #\D true empty))))))

;;create-node: (Anyof Node empty) (listof Char) -> Node
;;Requires:
;;    loC to be non empty
;;    the first element in loC matches the node-val of prevNode for accurate results. 
(define (create-node prevNode loC)
  (cond [(empty? prevNode) (cond [(empty? (rest loC)) (make-node (first loC) true empty)]
                                 [else (make-node (first loC)
                                                  false
                                                  (create-tree/next empty (rest loC)))])]
        [(empty? (rest loC)) (make-node (first loC) true (node-next prevNode))]
        [else (make-node (first loC) (node-term? prevNode)
                         (create-tree/next (node-next prevNode) (rest loC)))]))

;;
;;Part C)
;;
;;(check root word) checks if word is in the tree starting from root.
;;Examples:
(check-expect (check "sad" (make-node #\space false
                             (list (make-node #\S false
                                    (list (make-node #\A false
                                            (list (make-node #\D true empty)
                                                  (make-node #\S true empty)))))))) true)
(check-expect (check "SAD" (make-node #\space false
                             (list (make-node #\S false
                                    (list (make-node #\A false
                                            (list (make-node #\D true empty)
                                                  (make-node #\S true empty)))))))) true)
(check-expect (check "sAs" (make-node #\space false
                             (list (make-node #\S false
                                    (list (make-node #\A false
                                            (list (make-node #\D true empty)
                                                  (make-node #\S true empty)))))))) true)
(check-expect (check "sa" (make-node #\space false
                             (list (make-node #\S false
                                    (list (make-node #\A false
                                            (list (make-node #\D true empty)
                                                  (make-node #\S true empty)))))))) false)

;;check: Node Str -> Bool
(define (check word root)
  (check/nonSpace (node-next root) (string->list (string-upcase word)) false))

;;Tests:
(check-expect (check "sadi" (make-node #\space false
                             (list (make-node #\S false
                                    (list (make-node #\A false
                                            (list (make-node #\D true empty)
                                                  (make-node #\S true empty)))))))) false)
(check-expect (check "sab" (make-node #\space false
                             (list (make-node #\S false
                                    (list (make-node #\A false
                                            (list (make-node #\D true empty)
                                                  (make-node #\S true empty)))))))) false)
(check-expect (check "xaZ" (make-node #\space false
                                    (list (make-node #\X false
                                            (list (make-node #\A true empty)
                                                  (make-node #\Z true empty)))))) false)

;;(check/nonSpace next loC) checks if loCs are a member of next.
;;Examples:
(check-expect (check/nonSpace (list (make-node #\A true (list (make-node #\B true empty))))
                              (list #\A #\B #\C) false) false)

;;check/nonSpace: Next (listof Char) Bool -> Bool
;;requires:
;;   loC to be uppercase letters 
(define (check/nonSpace next loC term)
  (cond [(empty? loC) term]
        [(empty? next) false]
        [(char=? (first loC) (node-val (first next)))
         (check/nonSpace (node-next (first next)) (rest loC) (node-term? (first next)))]
        [(char<? (first loC) (node-val (first next))) false]
        [else (check/nonSpace (rest next) loC term)]))