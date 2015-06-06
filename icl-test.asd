(in-package :cl-user)
(defpackage icl-test-asd
  (:use :cl :asdf))
(in-package :icl-test-asd)

(defsystem #:icl-test
  :author '("marsam" "Javier Olaechea <pirata@gmail>")
  :license "<3"
  :depends-on (:icl
               :prove)
  :components ((:module "t"
                :components
                ((:test-file "icl"))))
  :defsystem-depends-on (:prove-asdf)
  :perform (test-op :after (op c)
                    (funcall (intern #.(string :run-test-system) :prove-asdf) c)
                    (asdf:clear-system c)))
