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
    
    
    method image() = "pelotaPenn.png"
    
	method caer(altura){
		position = game.at(position.x(), 0.max(position.y()-altura))
		
		
	}
}



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

