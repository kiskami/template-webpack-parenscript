"use strict"

(defvar *__PS_MV_REG*)

(imp6 *scene "phaser")

(expclass
 *main-menu *scene

 (defmethod constructor ()
   (super "MainMenu"))

 (defmethod create ()

   (ps:chain this add (image 512 384 "background"))
   (ps:chain this add (image 512 300 "logo"))
   (ps:chain this add (
		       text
		       512
		       460
		       "Main Menu"
		       (ps:create font-family "Arial Black"
				  font-size 38
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
		     ((ps:chain self scene start) "Game")
		     nil
		     )))
   )
 )
