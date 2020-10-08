import estaticos.*
import nivel.*
import wollok.game.*



object jugador{

    var property position = game.at(3,1)

    method image() = "roger2.png"
    
    method caer(altura){
		position = game.at(position.x(), 0.max(position.y()-altura))
		
	}
	method saltar(){
		// Salta todo lo que quiere las veces que quiere.
		// 5.times({n=> game.schedule(1000,{ position = game.at(position.x() , position.y()+1 )})})
		position = game.at(position.x() , 5.min(position.y()+1))
		
	}

	method irA(nuevaPosicion){
		
		if(nuevaPosicion.x() < 0){ position = game.at(0,nuevaPosicion.y()) }
		
		else{
			position = game.at(14.min(nuevaPosicion.x()),nuevaPosicion.y())	
			
		}
		
	}
	
}





object raqueta{
	
    var property position = jugador.position()
    	method image() = "raquetaNadal2.png"
}



 
	
 object pelota{

    var property position = game.at(5,0)
    // 1 Derecha, -1 izquierda
    var direccion = -1

    	method image() = "pelotaPenn.png"

    	method caer(altura){
       		position = game.at(position.x(), 0.max(position.y()-altura))
   }
		method cambiarDireccion(){direccion = direccion * (-1)}
		
    	method golpe(){	
    		
    		self.cambiarDireccion()
        	game.onTick(400,"Golpea pelota", {self.trayectoria()})
        	
   }

// Esta es una posible trayectoria para la pelota. Luego del golpe la pelota asciende hasta la mitad de la cancha y ahi empieza a descender.
// La raqueta deberia tener un method que sea impactarPelota() que llame al mensaje golpe() en la pelota, quizas con un tipo de trayectoria como parametro.

    	method trayectoria(){
    		
    		if(self.pasoMitadDeCancha()){
    			position = game.at(position.x()+(2 * direccion),position.y()+1)
			}else{
				position = game.at(position.x()+(2 * direccion),position.y()-1)
				// self.pique()
			}
	}
		method pasoMitadDeCancha(){
			return (position.x() > 15 && direccion == -1) || ( position.x() < 15 && direccion==1)
	}
		/*method pique(){
			if (position == game.at(0,position.y())){
				position = game.at(position.x()+(2 * direccion),position.y()+1)
			}
			
			
		}*/
}	
		/*Bueno ..... eeee no esta siendo la mejor forma de hacerlo asi.
		  Para mi hay que optar por asignarle una energia a la pelota y que el movimiento se a partir de esa energia
		  Entonces que por ejemplo method pique() lo que haga es sacarle energia a la pelota y que entonces baje mas rapido y/o avance mas lento 
		  
		 */


/* 
 object pelota{

    var property position = game.at(5,0)
    // 1 Derecha, -1 izquierda
    var direccion = -1
    var energiaDePelota = 100


    	method image() = "pelotaPenn.png"

    	method caer(altura){
       		position = game.at(position.x(), 0.max(position.y()-altura))
   }
		method cambiarDireccion(){direccion = direccion * (-1)}
		
    	method golpe(){	
    		
    		self.cambiarDireccion()
        	game.onTick(400,"Golpea pelota", {self.trayectoria()})
        	
   }
    	method trayectoria(){
    		
    			position = game.at(position.x()+(2 * direccion), position.y()+(energiaDePelota/10))
				self.pique()
			}

		method pique(){
			
			if (position == game.at(0,position.y())){
			 	energiaDePelota = 50
			}
		}
}

*/

























  
  