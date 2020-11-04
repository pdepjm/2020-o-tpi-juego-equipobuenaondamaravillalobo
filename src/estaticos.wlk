
import juego.*
import nivel.*
import wollok.game.*


class Red{
	  const property position 
      method image() = "red.png"  
}


const red1= new Red(position=game.at(75,0))
const red2= new Red(position=game.at(75,1))
const red3= new Red(position=game.at(75,2))
const red4= new Red(position=game.at(75,3))
const red5= new Red(position=game.at(75,4))
const red6= new Red(position=game.at(75,5))
const red7= new Red(position=game.at(75,6))
const red8= new Red(position=game.at(75,7))
const red9= new Red(position=game.at(75,8))



object contadorDePuntos{

        method inicializarPuntos(){
        	game.addVisual(jugador1.puntos())
        	game.addVisual(jugador2.puntos())
        }
       
        method sumarPunto(jugador){ 
		game.removeVisual(jugador.puntos())
		jugador.puntos(jugador.puntos().siguiente()) 
		game.addVisual(jugador.puntos())
	}
}

class Numero{
	const position
	const image
	const siguiente
	
	   method position()= position
	   method image()= image
	   method siguiente()= siguiente
}

class NumeroFinal inherits Numero{
	override method siguiente(){game.clear() return null }
        // game.addVisual() FALTARIA HACER QUE MUESTRE POR PANTALLA EL JUGADOR QUE GANÓ.... 
}

const cero = new Numero(image="cero.png",siguiente=uno,position = game.at(35,70))
const uno = new Numero(image="uno.png",siguiente=dos,position = game.at(35,70))
const dos = new Numero(image="dos.png",siguiente=tres,position = game.at(35,70))
const tres = new Numero(image= "tres.png",siguiente=cuatro,position = game.at(35,70))
const cuatro = new Numero(image="cuatro.png",siguiente=cinco,position = game.at(35,70))

const ceroBis = new Numero(image="cero.png",siguiente=unoBis,position = game.at(115,70))
const unoBis = new Numero(image="uno.png",siguiente=dosBis,position = game.at(115,70))
const dosBis = new Numero(image="dos.png",siguiente=tresBis,position = game.at(115,70))
const tresBis = new Numero(image= "tres.png",siguiente=cuatroBis,position = game.at(115,70))
const cuatroBis = new Numero(image="cuatro.png",siguiente=cincoBis,position = game.at(115,70))

const cinco = new NumeroFinal(image="cinco.png",siguiente=null,position = game.at(35,70))
const cincoBis = new NumeroFinal(image="cinco.png",siguiente=null,position = game.at(115,70))


object reproductorDeSonidos{
	var musicaAmbiente = game.sound("musicaAmbiente.mp3")
	//var sonidoDeGolpe = game.sound("sonidoDeGolpe.mp3")
	//var sonidoDeJugador = game.sound("jugadorGolpeando.mp3")

	method musicaAmbiente() = musicaAmbiente
	//method sonidoDeGolpe() = sonidoDeGolpe
	//method sondidoDeJugador() = sonidoDeJugador
}








                           







