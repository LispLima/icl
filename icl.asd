(defpackage #:icl-system
  (:use #:cl #:asdf))
(in-package #:icl-system)

(defsystem #:icl
  :name "icl"
  :author '("Mario Rodas"
            "Javier Olaechea <pirata@gmail>")
  :description "Jupyter kernel for Common Lisp"
  :version (:read-file-from "version.lisp-expr")
  :license "<3"
  :serial t
  :pathname "src"
  :depends-on ()
  :components ()
  :in-order-to ((test-op (load-op :icl-tests)))
  :perfom (test-op (o c)
                   (asdf/package:symbol-call :prove 'run icl-tests)))
