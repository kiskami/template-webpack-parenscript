"use strict"

(defvar *__PS_MV_REG*)

(imp6 *scene "phaser")

(expclass
 *game *scene

 (defmethod constructor ()
   (super "Game"))

 (defmethod create ()
   (ps:chain this cameras main (set-background-color 0x00ff00))
   (ps:chain this add (image 512 384 "background") (set-alpha 0.5))
   (ps:chain this add (
		       text
		       512
		       384
		       (ps:lisp (format nil  "Make something fun!~%and share it with us:~%support@phaser.io"))
		       (ps:create font-family "Arial Black"
				  font-size 38
				  color "#ffffff"
				  align "center"))
	     (set-origin 0.5))

   ;; lambda makes a function instead of arrows
   ;; thats why we need the outer this for the
   ;; next expression
   (ps:var self this)
   
   (ps:chain this input
	     (once "pointerdown"
		   (lambda ()
		     ((ps:chain self scene start) "GameOver")
		     nil
		     )))
   )
 )
