import juego.*
import estaticos.*
import nivel.*
import wollok.game.*

class Menu{
	var property image 
	var property position = game.at(0, 0)
	var visual = false
	
	method aparecerMenu()
	{
		if(!visual){
			game.addVisual(self)
			visual = true
		}
	}
		
	method sacarMenu(){
		if(visual){
			game.removeVisual(self)
			visual = false
			}
	}
	
	method visual() = visual
	
}

const menuInicio = new Menu(
	image = "menuInicial.png"
)
const menuSeleccion1 = new Menu(
	image = "menuSeleccion1.png"
)
const menuSeleccion2 = new Menu(
	image = "menuSeleccion2.png"
)

const jugador1Gano = new Menu(
	image = "jugador1Gano.png"
)

const jugador2Gano = new Menu(
	image = "jugador2Gano.png"
)
 
object detectorDeMenu{
	
	method detectarCambioDeMenu(){
		
		if(menuInicio.visual()){
	keyboard.space().onPressDo({
	 	menuInicio.sacarMenu()
	 	menuSeleccion1.aparecerMenu()
	 })
	 }
	if(menuSeleccion1.visual()){
		
	 	keyboard.num(1).onPressDo({
	 	cabeza1.image("cabezaRafa1.png")
	 	menuSeleccion1.sacarMenu()
	 	menuSeleccion2.aparecerMenu()
	 	})
	 	
	 keyboard.num(2).onPressDo({
		cabeza1.image("cabezaRoger2.png")
		menuSeleccion1.sacarMenu()
	 	menuSeleccion2.aparecerMenu()
	 	})
	 	
	  keyboard.num(3).onPressDo({
		cabeza1.image("cabezaDjoko1.png")
		menuSeleccion1.sacarMenu()
	 	menuSeleccion2.aparecerMenu()
		})	
	 }
	 if(menuSeleccion2.visual()){
	 	
	 	keyboard.num(4).onPressDo({
	 	cabeza2.image("cabezaRafa2.png")
	    partido.iniciar()
	 	game.removeTickEvent("Detectar cambio de menu")
	 	menuSeleccion2.sacarMenu()
	 	})
	 	
	 	keyboard.num(5).onPressDo({
		cabeza2.image("cabezaRoger3.png")
		partido.iniciar()
		game.removeTickEvent("Detectar cambio de menu")
		menuSeleccion2.sacarMenu() 
	 	})
	 	
	  keyboard.num(6).onPressDo({
		cabeza2.image("cabezaDjoko2.png")
		partido.iniciar()
		game.removeTickEvent("Detectar cambio de menu") 
		menuSeleccion2.sacarMenu()
		})	
	}	
	}
}