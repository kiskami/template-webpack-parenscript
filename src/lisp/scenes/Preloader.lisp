"use strict"

(defvar *__PS_MV_REG*)

(imp6 *scene "phaser")

(expclass
 *preloader *scene

 (defmethod constructor ()
   (super "Preloader"))

 (defmethod init ()
   ;; We loaded this image in our Boot Scene, so we can display it here
   (ps:chain this add (image 512 384 "background"))

   ;; A simple progress bar. This is the outline of the bar.
   (ps:chain this add (rectangle 512 384 468 32) (set-stroke-style 1 0xffffff))

   ;; This is the progress bar itself. It will increase in size from the left based on the % of progress.
   (defparameter bar
     (ps:chain this add (rectangle (- 512 230) 384 4 28 0xffffff)))

   ;; Use the 'progress' event emitted by the LoaderPlugin to update the loading bar
   (ps:chain this load (on "progress"
			   (lambda (progress)
			     ;; Update the progress bar (our bar is 464px wide, so 100% = 464px)
;;			     (ps:chain console (log "progress %d" progress))
			     (setf (ps:chain bar width) (+ (* 460 progress) 4))
			     nil)))
   nil
   )

 (defmethod preload ()
   ;;Load the assets for the game - Replace with your own assets
   (ps:chain this load (set-path "assets"))

   (ps:chain this load (image "logo" "logo.png"))
   )
 
 (defmethod create ()
   ;; When all the assets have loaded, it's often worth creating global objects here that the rest of the game can use.
   ;; For example, you can define global animations here, so we can use them in other scenes.

   ;; Move to the MainMenu. You could also swap this for a Scene Transition, such as a camera fade.
   (ps:chain this scene (start "MainMenu")))
 )
