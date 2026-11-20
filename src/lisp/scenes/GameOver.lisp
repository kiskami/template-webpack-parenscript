"use strict"

(defvar *__PS_MV_REG*)

(imp6 *scene "phaser")

(expclass
 *game-over *scene

 (defmethod constructor ()
   (super "GameOver"))

 (defmethod create ()
   (ps:chain this cameras main (set-background-color 0xff0000))
   (ps:chain this add (image 512 384 "background") (set-alpha 0.5))
   (ps:chain this add (
		       text
		       512
		       384
		       "Game Over"
		       (ps:create font-family "Arial Black"
				  font-size 64
				  color "#ffffff"
				  stroke "#000000"
				  stroke-thickness 8
				  align "center"))
	     (set-origin 0.5))

   ;; lambda makes a function instead of arrows
   ;; thats why we need the outer this for the
   ;; next expression
   (ps:var self this)
   
   (ps:chain this input
	     (once "pointerdown"
		   (lambda ()
		     ((ps:chain self scene start) "MainMenu")
		     nil
		     )))
   )
 )
