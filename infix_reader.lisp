(defpackage #:prefix-reader (:use :cl)
            (:export enable-prefix-reader
                     disable-prefix-reader))
(in-package #:prefix-reader)

(defun read-as-string (stream) (write-to-string (read stream)))
(defun read-in-delimiters (stream begin end)
  (prog1
      (with-output-to-string (out)
        (write-char #\( out)
        (loop for next = (peek-char nil stream nil nil t)
              until (equal next end)
              do (if (equal next begin)
                     (write-string (read-as-string stream) out)
                     (write-char (read-char stream nil nil t) out)))
        (write-char #\) out))
    (read-char stream nil nil t)))
(defun infix-reader (stream char)
  (declare (ignore char))
  (let ((string (read-in-delimiters stream #\{ #\})))
    (destructuring-bind (a func b) (read-from-string string) 
      `(,func ,a ,b))))
(defun infix-end (stream char)
  (declare (ignore char stream))
  (error "#} Should not be read!"))

(defvar *readtables* nil)

(defmacro enable-prefix-reader ()
  '(eval-when (:compile-toplevel :load-toplevel :execute)
    (push *readtable* *readtables*)
    (setq *readtable* (copy-readtable))
    (set-macro-character #\{ #'infix-reader nil)
    (set-macro-character #\} #'infix-end nil)))

(defmacro disable-prefix-reader ()
  '(eval-when (:compile-toplevel :load-toplevel :execute)
    (setq *readtable* (pop *readtables*))))


