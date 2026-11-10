;import StartGame from './game/main';
(let ((*start-Game (parenscript:chain (require "../game/main.js") default)))
 (defvar *__PS_MV_REG*)

 (parenscript:chain document
		    (add-event-listener "DOMContentLoaded"
					(lambda () (*start-Game "game-container")))))
  

