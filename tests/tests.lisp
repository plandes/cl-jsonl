(defpackage #:cl-jsonl/tests
  (:use #:cl
	#:fiveam
	#:arrows
	#:gtwiwtg
	#:access
	#:alexandria
	#:cl-jsonl))
(in-package :cl-jsonl/tests)

(defvar test-path
  (asdf:system-relative-pathname :cl-jsonl #p"tests/test.json"))

(def-suite cl-jsonl)
(in-suite cl-jsonl)

(test file-exists
  (is (not (null (probe-file test-path)))))

(test read-json-singleton
  (is (equal '("fish")
	     (with-json-reader (ge test-path)
	       (->> ge
		    (filter! (lambda (arg)
			       (equal "animal" (car (hash-table-keys arg)))))
		    (map! (lambda (arg)
			    (accesses arg "animal" "first")))
		    (take 1))))))

(test read-json-all
  (is (equal '("fish" "cat")
	     (with-json-reader (ge test-path)
	       (->> ge
		    (filter! (lambda (arg)
			       (equal "animal" (car (hash-table-keys arg)))))
		    (map! (lambda (arg)
			    (accesses arg "animal" "first")))
		    collect)))))
