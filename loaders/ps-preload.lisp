
(unless (asdf:find-system "parenscript" nil)
  (format t "Trying to load parenscript.~%")
  (ql:quickload "parenscript")
  )
(require :parenscript)

;; utility
;; based on:  https://mailman3.common-lisp.net/hyperkitty/list/parenscript-devel@lists.common-lisp.net/message/MR3DLVANKTB5FWZCSCAAAALVSFIPSF4U/
(ps::define-expression-operator inline-js (x) `(ps-js:escape ,x))

;; simple ES6 style import
(ps:defpsmacro imp6 (what modulename)
  (let ((s (format nil "import { ~A } from '~A'"
		   (if (listp what)
		       (format nil "~{~A~^ ~}"
			       (map 'list
				    #'(lambda (item)
					(ps:symbol-to-js-string item))
				    what)
			 )
		       (ps:symbol-to-js-string what))
		   modulename)))
    `(inline-js ,s)))

;; simple ES6 style class and export
(ps:defpsmacro expclass (name extends &body body)
  (let ((s (format nil "export class ~A ~A {"
		   (ps:symbol-to-js-string name)
		   (if extends
		       (format nil "extends ~A"
			       (ps:symbol-to-js-string extends))
		       "")
		   )))
    `(progn
       (inline-js ,s)
       ,@body
       (inline-js "}"))
    ))

;; ripped from parenscript
;; compile and print method def without function keyword
(ps::define-statement-operator defmethod% (name lambda-list &rest body)
  (multiple-value-bind (effective-args body-block docstring)
      (ps::compile-named-function-body name lambda-list body)
    (list 'ps-js:defun (list "" name)
	  effective-args docstring body-block)))

;; ripped from parenscript
(ps:defpsmacro defmethod (name lambda-list &body body)
  (assert (symbolp name) () "setf not supported for name") 
  ;;(setf (gethash name ps::*function-lambda-list*) lambda-list)
  `(defmethod% ,name ,lambda-list ,@body))
