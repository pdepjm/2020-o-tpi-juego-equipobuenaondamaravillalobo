
import juego.*
import nivel.*
import wollok.game.*
import menu.*

object red{
	const redes=[
	  	new PedazoDeRed(position=game.at(75,0)),
		new PedazoDeRed(position=game.at(75,1)),
 		new PedazoDeRed(position=game.at(75,2)),
		new PedazoDeRed(position=game.at(75,3)),
		new PedazoDeRed(position=game.at(75,4)),
 		new PedazoDeRed(position=game.at(75,5)),
 		new PedazoDeRed(position=game.at(75,6)),
		new PedazoDeRed(position=game.at(75,7)),
		new PedazoDeRed(position=game.at(75,8))
	  ] 
	
	method aparecerRed(){
      	redes.forEach({red => game.addVisual(red)})
      }
	method rangoDeRed(posicionEnX,posicionEnY) = posicionEnX >= 70 and posicionEnX <= 73 and posicionEnY < 10
      
}

class PedazoDeRed{
	  const position
	  
	  method position()= position
	  method image() = "red.png"  
}






object contadorDePuntos{

        method inicializarPuntos(){
        	game.addVisual(contadorJ1)
        	game.addVisual(contadorJ2)
        }
       
        method sumarPunto(jugador){ 
		jugador.puntos(jugador.puntos() + 1)
		jugador.contador().numeroSiguiente() 
	}
}

class Contador{
	const position
	var image 
	var numero
	
	   method position()= position
	   method image()= numero.toString() + ".png"
	   method numeroSiguiente(){
	   	numero += 1
	   	self.verificacionNumeroFinal()
	   }
	   method verificacionNumeroFinal(){
	   	if(numero == 6){
	   		game.clear()
		if(jugador1.puntos()==6){
			game.addVisual(jugador1Gano)
			game.addVisualCharacterIn(cabeza1, game.at(750,200))
			game.schedule(1800,{game.stop()})
		}
		else{
			game.addVisual(jugador2Gano)
			game.addVisualCharacterIn(cabeza2, game.at(750,200))
			game.schedule(1800,{game.stop()})
			}
	   	}
	   }
	   
}

const contadorJ1 = new Contador(position = game.at(35,70), numero = 0,image="0.png" )
const contadorJ2 = new Contador(position = game.at(115,70), numero = 0,image="0.png")


object reproductorDeSonidos{
	var musicaAmbiente = game.sound("musicaAmbiente.mp3")
	//var sonidoDeGolpe = game.sound("GritoPegada.mp3")
	//var sonidoDeJugador = game.sound("jugadorGolpeando.mp3")

	method musicaAmbiente() = musicaAmbiente
	//method sonidoDeGolpe()= sonidoDeGolpe
	//method sonidoDeGolpe() = sonidoDeGolpe
	//method sondidoDeJugador() = sonidoDeJugador
}








                           







