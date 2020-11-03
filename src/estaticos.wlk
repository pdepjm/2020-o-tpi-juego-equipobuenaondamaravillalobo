
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

/* 
object puntajeJugador1{
	

	method mostrarPuntos(){
		if(jugador1.puntos()==cero){
			game.addVisual(cero)
		}else if(jugador1.puntos()==uno){
			game.addVisual(uno)
		}else if(jugador1.puntos()==dos){
			game.addVisual(dos)
		}else if(jugador1.puntos()==tres){
			game.addVisual(tres)
		}else if(jugador1.puntos()==cuatro){
			game.addVisual(cuatro)
		}else{
			game.addVisual(cinco)
			game.schedule(2000,game.stop())
		}
	}
}*/

/* 
object puntajeJugador2{
	

	method mostrarPuntos(){
		if(jugador2.puntos()==1){
			game.addVisual(unoBis)
		}else if(jugador2.puntos()==2){
			game.addVisual(dosBis)
		}else if(jugador2.puntos()==3){
			game.addVisual(tresBis)
		}else if(jugador2.puntos()==4){
			game.addVisual(cuatroBis)
		}else if(jugador2.puntos()==5){
			game.addVisual(cinco)
			game.schedule(2000,game.stop())
		}else if(jugador2.puntos()==0){
		    game.addVisual(ceroBis)
		}else{
			
		}
	}
}

*/








                           







