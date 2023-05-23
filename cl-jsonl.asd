;;;; cl-jsonl.asd

(asdf:defsystem #:cl-jsonl
  :description "Lazy read JSONL files with each line a separate definition."
  :author "Paul Landes <landes@mailc.net>"
  :license "MIT"
  :version "0.1.0"
  :depends-on ("gtwiwtg"
	       "yason")
  :pathname #P"src/"
  :components ((:file "jsonl"))
  :in-order-to ((test-op (test-op "cl-jsonl/tests"))))

(asdf:defsystem #:cl-jsonl/tests
  :description "Unit tests for the cl-jsonl library."
  :author "Paul Landes <landes@mailc.net>"
  :license "MIT"
  :depends-on ("fiveam"
	       "arrows"
	       "access"
	       "cl-jsonl")
  :pathname #P"tests/"
  :components ((:file "tests"))
  :perform (test-op (op c)
                    (symbol-call :fiveam :run!
                                 (find-symbol* :cl-jsonl :cl-jsonl/tests))))
