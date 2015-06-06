(in-package :cl-user)
(defpackage icl-test
  (:use :cl
        :icl
        :prove))
(in-package :icl-test)

(plan 13)

(is 4 4)
;; (isnt 1 #\1)

(finalize)
