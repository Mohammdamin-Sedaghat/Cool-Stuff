;;Examples
(check-expect (date->day-of-week 20240919) 'Thursday)
(check-expect (date->day-of-week 20240924) 'Tuesday)
(check-expect (date->day-of-week 38781202) 'Monday)
(check-expect (date->day-of-week 19450728) 'Saturday)
(check-expect (date->day-of-week 18211209) 'Sunday)
(check-expect (date->day-of-week 20011105) 'Monday)
(check-expect (date->day-of-week 19930623) 'Wednesday)

;;(date->day-of-week date) returns the day of the week based on the date of today
(define (date->day-of-week date)
  (num->symbol-day (modulo (+
                            (- (year date) 1753)
                            (quotient (- (year date) 1753) 4) ;if year is divisable by 4 its leap year
                            (- (quotient (- (year date) 1700) 100)) ;unless if its divisable by 100
                            (quotient (- (year date) 1600) 400) ;but if its divisable by 400 its leap
                            (month-value (month date) (year date))
                            (- (day date) 1)) 7)))


;;(num->symbol-day num-day) returns the symbol of the day of the week based on
;;the number assigned to the day
(define (num->symbol-day num-day)
  (cond [(= num-day 0) 'Monday]
        [(= num-day 1) 'Tuesday]
        [(= num-day 2) 'Wednesday]
        [(= num-day 3) 'Thursday]
        [(= num-day 4) 'Friday]
        [(= num-day 5) 'Saturday]
        [(= num-day 6) 'Sunday]))


;;(year date) returns the year based on the date given
(define (year date) (quotient date 10000))
;;(month date) returns the month based on the date given
(define (month date) (quotient (modulo date 10000) 100))
;;(day date) returns the day of the month based on the date given
(define (day date) (modulo date 100))

;;(month-value month year) returns the difference between the first day of the month and the
;;start of the year when given a month and a year
(define (month-value month year)
  (cond [(leap-year? year) (cond [(or (= month 1) (= month 4) (= month 7)) 0]
                                     [(= month 10) 1]
                                     [(= month 5) 2]
                                     [(or (= month 2) (= month 8)) 3]
                                     [(or (= month 3) (= month 11)) 4]
                                     [(= month 6) 5]
                                     [(or (= month 9) (= month 12)) 6])]
        [(or (= month 1) (= month 10)) 0]
        [(= month 5) 1]
        [(= month 8) 2]
        [(or (= month 2) (= month 3) (= month 11)) 3]
        [(= month 6) 4]
        [(or (= month 9) (= month 12)) 5]
        [(or (= month 4) (= month 7)) 6]))

;;(leap-year? year) returns a boolean value stating whether its a leap year or not
(define (leap-year? year)
  (or (= (modulo year 400) 0)
      (and (not (= (modulo year 100) 0))
           (= (modulo year 4) 0))))