(in-package :cl-user)
(defpackage icl-asd
  (:use :cl :asdf))
(in-package :icl-asd)

(defsystem #:icl
  :name "icl"
  :author '("Mario Rodas"
            "Javier Olaechea <pirata@gmail>")
  :description "Jupyter kernel for Common Lisp"
  :license "<3"
  :depends-on ()
  :components ((:module "src"
                :components
                ((:file "main"))))
  :long-description
  #.(with-open-file (stream (merge-pathnames
                             #p"README.md"
                             (or *load-pathname* *compile-file-pathname*))
                            :if-does-not-exist nil
                            :direction :input)
      (when stream
        (let ((seq (make-array (file-length stream)
                               :element-type 'character
                               :fill-pointer t)))
          (setf (fill-pointer seq) (read-sequence seq stream))
          seq)))
  :in-order-to ((test-op (load-op :icl-tests))))
