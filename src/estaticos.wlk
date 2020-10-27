
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
	var property position = game.at(75,70)
	var property cantidad = cero 
    method comenzarConteo(){
    	
    	game.onTick(1000,"ConteoInicial",{self.variarSegundos})
    	
        game.onTick(10000,"Conteo",{self.variarSegundos()})
    }
    
    method variarSegundos(){
    
    	game.addVisual(cantidad)
    }
}
object cero{
	
}
object uno{var property position = game.at(75,70)
	method image()= "roger2.png"
}
object dos{var property position = game.at(75,70)}
object tres{var property position = game.at(75,70)}
object cuatro{var property position = game.at(75,70)}
object cinco{var property position = game.at(75,70)}
object seis{var property position = game.at(75,70)}
object siete{var property position = game.at(75,70)}
object ocho{var property position = game.at(75,70)}
object nueve{var property position = game.at(75,70)}


*/


//DISTINTOS TIPOS DE GOLPES 
// CADA TECLA UN TIPO DE GOLPE
// PARA HACER HOY PA: DIEGO QUIERE OBJETO RED(QUE MIERDA HACE LA PELOTA CUANDO COLISIONA INSTA),
// COMO LOS != GOLPES DE CADA JUGADOR(OPCIONES: CADA TECLA UN TIPO DE GOLPE, LISTA DE GOLPES AL AZAR,)
// POSICION DE JUGADOR, SETTEADA POR MAX Y MIN






                           







