;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname bonus-a03) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor mixed-fraction #f #t none #f () #t)))
;;
;;********************************************
;;     Mohammadamin Sedaghat(21132158)
;;     CS 135 Fall 2024 Section 007
;;     Assignment A03, Problem 5
;;********************************************
;;

(define-struct box (xmin xmax ymin ymax))
;;A Box is a (make-box Num Num Num Num)
;;Recquires:
;;   xmax >= xmin
;;   ymax >= ymin

;;(overlap-area b1 b2) returns the overlap area of two boxes.
;;Examples:
(check-expect (overlap-area
               (make-box 2 8 2 9) (make-box 3 9 1 7)) 25)
(check-expect (overlap-area
               (make-box 4 6 1 7) (make-box -5 5 2 12)) 5)
(check-expect (overlap-area
               (make-box 3 9 4 7) (make-box 0 9 0 9)) 18)
(check-expect (overlap-area
               (make-box -1 9 -3 10) (make-box 4 11 6 13)) 20)

;;overlap-area: Box Box -> Num
(define (overlap-area b1 b2)
 (cond [(or (>= (box-xmin b1) (box-xmax b2))
            (>= (box-xmin b2) (box-xmax b1))
            (>= (box-ymin b1) (box-ymax b2))
            (>= (box-ymin b2) (box-ymax b1))) 0] ;Check if the boxes overlap.
       [(> (box-xmax b2) (box-xmax b1)) (overlap-area b2 b1)]
       [(>= (box-ymax b2) (box-ymax b1))
        (* (- (box-xmax b2) (max (box-xmin b2) (box-xmin b1)))
           (- (box-ymax b1) (max (box-ymin b2) (box-ymin b1))))]
       [else
        (* (- (box-xmax b2) (max (box-xmin b2) (box-xmin b1)))
           (- (box-ymax b2) (max (box-ymin b2) (box-ymin b1))))]))


;:Tests:
(check-expect (overlap-area
               (make-box 1 10 1 10) (make-box 3 6 4 11)) 18)
(check-expect (overlap-area
               (make-box 3 6 5 11) (make-box -12 7 -12 11)) 18)
(check-expect (overlap-area
               (make-box -13 13 6 12) (make-box 0 14 8 9)) 13)
(check-expect (overlap-area
               (make-box 0 20 8 9) (make-box -1 13 7.3 11.8)) 13)
(check-expect (overlap-area
               (make-box 1 12.8 3 3.4) (make-box 2 11 2 3.2)) 1.8)
(check-expect (overlap-area
               (make-box 2 11 2 3.2) (make-box 1 12.8 3 3.4)) 1.8)
(check-expect (overlap-area
               (make-box 0 18.5 6 10) (make-box 4 18.5 3.3 10)) 58)
(check-expect (overlap-area
               (make-box 0 12 0 21) (make-box -3 12 -5 22)) 252)
(check-expect (overlap-area
               (make-box -3.6 14 5 6) (make-box 13 14 4.99 63)) 1)
(check-expect (overlap-area
               (make-box 0 3 0 6) (make-box 3 4.5 6 7)) 0)
(check-expect (overlap-area
               (make-box 12 13 1 6.53) (make-box -3 12 6.53 54/7)) 0)
(check-expect (overlap-area
               (make-box 0 3 0 16) (make-box 3 25 0 16)) 0)