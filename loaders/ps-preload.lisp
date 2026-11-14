
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
