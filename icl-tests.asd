(defpackage #:icl-tests-system
  (:use #:cl #:asdf))
(in-package #:icl-tests-system)

(defsystem #:icl-tests
  :name "icl"
  :author '("Marsam" "Javier Olaechea <pirata@gmail>")
  :description "Test system for the icl system"
  :version (:read-file-from "version.lisp-expr")
  :license "<3"
  :serial t
  :pathname "t"
  :depends-on (#:icl
               #:prove)
  :defsystem-depends-on (#:prove-asdf)
  :components ())
