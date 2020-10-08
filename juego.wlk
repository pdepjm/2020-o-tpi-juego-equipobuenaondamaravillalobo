import estaticos.*
import nivel.*
import wollok.game.*



object roger{

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
	
    var property position = roger.position()
    	method image() = "raquetaNadal2.png"
}

	
 object pelota{

    var property position = game.at(5,5)
    // 1 Derecha, -1 izquierda
    var direccion = -1

    	method image() = "pelotaPenn.png"

    	method caer(altura){
       		position = game.at(position.x(), 0.max(position.y()-altura))
   }
		method cambiarDireccion(){direccion = direccion * (-1)}
		
    	method golpe(){	
    		
    		self.cambiarDireccion()
    		
    	//	4.randomUpTo(8).times({self.trayectoria()})
    		
        	game.onTick(400,"Golpea pelota", {self.trayectoria()})
        	
   }
/* 
   		 method movimientoSegunRafa(){
        	game.onTick(400,"GolpePelotaDerecho", {self.golpeDerecha()})
   }
*/
    	method trayectoria(){
    		if(self.pasoMitadDeCancha()){
    			position = game.at(30.min(position.x()+(2 * direccion)),0.max(position.y()+1))
			}else{
				position = game.at(0.max(position.x()+(2 * direccion)),0.max(position.y()-1))
			}
		}
		
}	
		method pasoMitadDeCancha(){
			return (position.x() > 14 && direccion == 1) || ( position.x() < 18 && direccion==-1)
		}
/* 
  		method golpeDerecha(){
      		if(position.x()<15){ 
        	position = game.at(0.max(position.x()-2),0.max(position.y()-1))
        	}else{
            position = game.at(0.max(position.x())-2,0.max(position.y()+1))
            }
  }*/


/* 
 * 
 * 
 object rafa{
    var property position = game.at(9,1)
    method image() = "rafa.png"
}
* 
* 
object raquetaRafa{
    var property position = game.at(rafa.position().x()) + 1 ,rafa.position().y()
    method image() = "raqueta2.png"

}

*/

