import juego.*
import estaticos.*
import wollok.game.*



object partido{
	
		method iniciar() {
		game.addVisualCharacter(roger)
		game.addVisual(pelota)		
		game.addVisual(red)
		game.addVisual(raqueta)
		config.configurarTeclas()
		game.onTick(500,"Gravedad", {pelota.caer(0.5)})
		game.onTick(500,"Gravedad", {roger.caer(0.5)})
	}
	
}




object config {

	method configurarTeclas() {
		keyboard.left().onPressDo({ roger.irA(roger.position().left(1))})
		keyboard.right().onPressDo({ roger.irA(roger.position().right(1))})
		keyboard.up().onPressDo({ roger.irA(roger.position().up(1))})
		keyboard.down().onPressDo({ roger.irA(roger.position().down(1))})
		
		}
	}

















