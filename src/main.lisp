(in-package #:cl-user)

(defpackage #:icl
  (:use #:cl)
  (:export #:main))

(in-package #:icl)


(defun main (argv)
  (format t "Hello world!"))
