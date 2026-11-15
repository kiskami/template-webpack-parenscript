"use strict"

(defvar *__PS_MV_REG*)

(imp6 *boot "../lisp/scenes/Boot")
(imp6 (:*game :as :*Main-Game) "../game/scenes/Game")
(imp6 *game-Over "../game/scenes/GameOver")
(imp6 *main-Menu "../game/scenes/MainMenu")
(imp6 *preloader "../game/scenes/Preloader")

;; Find out more information about the Game Config at:
;; https://docs.phaser.io/api-documentation/typedef/types-core#gameconfig  
(defparameter *config*
  (ps:create
   type (ps:@ *phaser *auto*)
   width 1024
   height 768
   parent "game-container"
   backgroundColor #x028af8
   scale (ps:create
	  mode (ps:@ *phaser *scale *fit*)
	  auto-Center (ps:@ *phaser *scale *center_both*))
   scene (ps:array
	  *boot
	  *preloader
	  *main-Menu
	  *main-game
	  *game-Over)
   callbacks (ps:create
	      post-boot (lambda (game)
			  ((ps:chain game scene dump)
			   )
			  nil))))

(defparameter *start-Game
  (lambda (config parent_)
    (setf (ps:@ config parent) parent_)
    (ps:new ((ps:@ *phaser *game) config))
    ))

(ps:chain document
	  (add-event-listener "DOMContentLoaded"
			      (lambda () (*start-Game *config* "game-container"))))

(ps:chain console (log "started"))
