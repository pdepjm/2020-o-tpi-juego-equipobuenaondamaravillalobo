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



const jugador1Gano = new Menu(
	image = "jugador1Gano.png"
)

const jugador2Gano = new Menu(
	image = "jugador2Gano.png"
)

const menuInicio = new Menu(
	image = "menuInicial.png"
)
const menuSeleccion1 = new Menu(
	image = "menuSeleccion1.png"
)
 
 class VisualesDelJugador{
 	var imageDerecha
 	var imageIzquierda
 	var menuSinVos
 	
 	method imageDerecha() = imageDerecha
 	method imageIzquierda() = imageIzquierda
 	method menuSinVos() = menuSinVos

 }
 
 const rafa = new VisualesDelJugador(imageDerecha = "cabezaRafa2.png",
 	imageIzquierda = "cabezaRafa1.png",
 	menuSinVos ="menuSeleccion2SinRafa.png"
 )
 const roger = new VisualesDelJugador(imageDerecha = "cabezaRoger3.png", 
 	imageIzquierda= "cabezaRoger2.png",
 	menuSinVos ="menuSeleccion2SinRoger.png"
 )
 
 const djoko = new VisualesDelJugador(imageDerecha = "cabezaDjoko2.png",
 	imageIzquierda = "cabezaDjoko.png",
 	menuSinVos ="menuSeleccion2SinDjoko.png"
 )
 
 object listaDeJugadores{
 	const jugadoresDisponibles = #{rafa,roger,djoko}
 	
 	method jugadoresDisponibles() = jugadoresDisponibles
 	method ocuparJugador(jugador){
 		jugadoresDisponibles.remove(jugador)
 	}
 	method remover(jugador){
 		jugadoresDisponibles.remove(jugador)
 	}
 }
 
 
 object losMenues{

    method configurarTeclasMenu(){

      
   	keyboard.space().onPressDo({
         menuInicio.sacarMenu()
         menuSeleccion1.aparecerMenu()
         keyboard.space().onPressDo({})
     })
    keyboard.num(1).onPressDo({
     	 self.elegirJugador1(rafa)
     	 keyboard.num(1).onPressDo({})
         })
 	keyboard.num(2).onPressDo({
     	keyboard.num(2).onPressDo({})
     	self.elegirJugador1(roger)
         })
 	keyboard.num(3).onPressDo({
     	keyboard.num(3).onPressDo({})
     	self.elegirJugador1(djoko)
         })
	 keyboard.num(4).onPressDo({
	 	keyboard.num(4).onPressDo({})
	 	self.elegirJugador2(rafa)
	 })
     keyboard.num(5).onPressDo({
     	keyboard.num(5).onPressDo({})
     	self.elegirJugador2(roger)
     })
     keyboard.num(6).onPressDo({
     	keyboard.num(6).onPressDo({})
     	self.elegirJugador2(djoko)
     })
 }
    
 method elegirJugador1(jugador){

         if(listaDeJugadores.jugadoresDisponibles().contains(jugador)){
         cabeza1.image(jugador.imageIzquierda())
         menuSeleccion1.sacarMenu()
         segundoMenu.aparecer(jugador)
         listaDeJugadores.remover(jugador)
 }}
  method elegirJugador2(jugador){

         if(listaDeJugadores.jugadoresDisponibles().contains(jugador)){
         cabeza2.image(jugador.imageDerecha())
         game.clear()
         partido.iniciar()
 }}


}

object segundoMenu{
	method crearMenu(jugador) = new Menu(image = jugador.menuSinVos())
	
	method aparecer(jugador){
		self.crearMenu(jugador).aparecerMenu()
		

		
	}
	
}











