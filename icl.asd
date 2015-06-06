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
  :depends-on ()
  :components ((:module "src"
                :components
                ((:file "main"))))
  :in-order-to ((test-op (load-op :icl-tests))))
