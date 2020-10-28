
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





/* 
object contadorDeSegundos{
	va rproperty position = game.at(75,70)
	var property cantidad = cero 
    method comenzarConteo(){
    	
    	game.onTick(1000,"ConteoInicial",{self.variarSegundos})
    	
        game.onTick(10000,"Conteo",{self.variarSegundos()})
    }
    
    method variarSegundos(){
    
    	game.addVisual(cantidad)
    }
}
* 
*/

object cero{var property position = game.at(35,70)
	method image()= "cero.png"}
object uno{var property position = game.at(35,70)
	method image()= "uno.png"
}
object dos{var property position = game.at(35,70)
		method image()= "dos.png"
}
object tres{var property position = game.at(35,70)
		method image()= "tres.png"
}
object cuatro{var property position = game.at(35,70)
		method image()= "cuatro.png"
}
object cinco{var property position = game.at(35,70)
		method image()= "cinco.png"
}



object ceroBis{var property position = game.at(115,70)
	method image()= "cero.png"}
object unoBis{var property position = game.at(115,70)
	method image()= "uno.png"
}
object dosBis{var property position = game.at(115,70)
		method image()= "dos.png"
}
object tresBis{var property position = game.at(115,70)
		method image()= "tres.png"
}
object cuatroBis{var property position = game.at(115,70)
		method image()= "cuatro.png"
}
object cincoBis{var property position = game.at(115,70)
		method image()= "cinco.png"
}
object puntajeJugador1{
	

	method mostrarPuntos(){
		if(jugador.puntos()==1){
			game.addVisual(uno)
		}else if(jugador.puntos()==2){
			game.addVisual(dos)
		}else if(jugador.puntos()==3){
			game.addVisual(tres)
		}else if(jugador.puntos()==4){
			game.addVisual(cuatro)
		}else if(jugador.puntos()==5){
			game.addVisual(cinco)
			game.schedule(2000,game.stop())
		}else if(jugador.puntos()==0){
		    game.addVisual(cero)
		}else{
			
		}
	}
}

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










                           







