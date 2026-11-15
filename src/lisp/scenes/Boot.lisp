"use strict"

(defvar *__PS_MV_REG*)

(imp6 *scene "phaser")

(expclass
 *boot *scene

 (defmethod constructor ()
   (super "Boot"))

 (defmethod preload ()
   ((ps:chain this load image) "background" "assets/bg.png"))

 (defmethod create ()
   ((ps:chain this scene start) "Preloader"))
 
 )
