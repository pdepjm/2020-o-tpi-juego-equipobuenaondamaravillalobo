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
const menuSeleccion2SinRafa = new Menu(
	image = "menuSeleccion2SinRafa.png"
)
const menuSeleccion2SinRoger = new Menu(
	image = "menuSeleccion2SinRoger.png"
)
const menuSeleccion2SinDjoko = new Menu(
	image = "menuSeleccion2SinDjoko.png"
)
 
 class CabezaDeJugador{
 	var imageDerecha
 	var imageIzquierda
 	var idCabeza
 	method imageDerecha() = imageDerecha
 	method imageIzquierda() = imageIzquierda
 	method idCabeza() = idCabeza
 }
 
 const rafa = new CabezaDeJugador(imageDerecha = "cabezaRafa2.png",
 	imageIzquierda = "cabezaRafa1.png",
 	idCabeza = 1
 )
 const roger = new CabezaDeJugador(imageDerecha = "cabezaRoger3.png", 
 	imageIzquierda= "cabezaRoger2.png",
 	idCabeza = 2
 )
 const djoko = new CabezaDeJugador(imageDerecha = "cabezaDjoko2.png",
 	imageIzquierda = "cabezaDjoko.png",
 	idCabeza = 3
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
 
 
 object detectorDeMenu{

    method detectarCambioDeMenu(){

        if(menuInicio.visual()){
   		 keyboard.space().onPressDo({
         menuInicio.sacarMenu()
         menuSeleccion1.aparecerMenu()
     })
     }
    if(menuSeleccion1.visual()){

         keyboard.num(1).onPressDo({self.elegirJugador1(1)})
         keyboard.num(2).onPressDo({self.elegirJugador1(2)})
         keyboard.num(3).onPressDo({self.elegirJugador1(3)})

 }
     if(menuSeleccion2SinRafa.visual() || 
         menuSeleccion2SinRoger.visual() ||
         menuSeleccion2SinDjoko.visual()
     ){

         keyboard.num(4).onPressDo({self.elegirJugador2(1)})
         keyboard.num(5).onPressDo({self.elegirJugador2(2)})
         keyboard.num(6).onPressDo({self.elegirJugador2(3)})
 	}
 }
 
 method elegirJugador1(idCabezaBuscada){
         var jugadorElegido 

         jugadorElegido = listaDeJugadores.jugadoresDisponibles().find({unaCabeza => unaCabeza.idCabeza() == idCabezaBuscada})
         cabeza1.image(jugadorElegido.imageIzquierda())
         menuSeleccion1.sacarMenu()
         self.aparecerMenuSegunEleccion(idCabezaBuscada)
         listaDeJugadores.remover(jugadorElegido)
 }
  method elegirJugador2(idCabezaBuscada){
         var jugadorElegido

         jugadorElegido = listaDeJugadores.jugadoresDisponibles().find({unaCabeza => unaCabeza.idCabeza() == idCabezaBuscada})
         cabeza2.image(jugadorElegido.imageDerecha())
         game.removeTickEvent("Detectar cambio de menu")
         game.clear()
         partido.iniciar()
 }
 
 method aparecerMenuSegunEleccion(id){
     if(id == 1){ 
         menuSeleccion2SinRafa.aparecerMenu()
         }else{
             if(id == 2){ 
         menuSeleccion2SinRoger.aparecerMenu()}
         else{
             menuSeleccion2SinDjoko.aparecerMenu()
         }
         }
 }
 
 }
















