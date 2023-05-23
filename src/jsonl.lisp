;;;; jsonl.lisp

(defpackage #:cl-jsonl
  (:documentation
   "A `gtwiwtg::generator!' class that iterates over JSON entries in files.")
  (:use #:cl)
  (:export #:with-json-reader))
(in-package #:cl-jsonl)

(use-package :gtwiwtg)

(defclass json-reader (gtwiwtg::generator!)
  ((file-name :initarg :file-name
	      :documentation "\
The JSON file name usually with a `.jsonl' extension.")
   (stream :initform nil)
   (next-entry :initform nil))
  (:documentation "Iterates over multi-line JSON files."))

(defmethod initialize-instance :after ((g json-reader) &key)
  (with-slots (file-name stream) g
    (setf stream (open file-name))))

(defmethod gtwiwtg::next ((g json-reader))
  (with-slots (stream next-entry) g
    (flet ((read-json ()
	     (let ((res (handler-case
			    (yason:parse stream)
			  (end-of-file (c)
			    (declare (ignore c))
			    :eof))))
	       (when (eq res :eof)
		 (json-reader-close g))
	       res)))
      (when stream
	(unless next-entry
	  (setf next-entry (read-json)))
	(prog1 next-entry
	  (setf next-entry (read-json)))))))

(defmethod gtwiwtg::has-next-p ((g json-reader))
  (not (null (slot-value g 'stream))))

(defmethod json-reader-close ((g json-reader))
  "Close the reader regardless if the end was iterated."
  (with-slots (stream) g
    (when stream
      (close stream)
      (setf stream nil))))

(defmacro with-json-reader ((gen file-name) &body body)
  "Iterate `gtwiwtg' generator GEN through FILE-NAME each entry.
Each iteration reads a line from the file and parses it as a JSON string."
  `(progn
     (assert (typep ,file-name 'pathname))
     (let ((,gen (make-instance 'json-reader :file-name ,file-name)))
       (unwind-protect
	    (progn ,@body)
	 (json-reader-close ,gen)))))
