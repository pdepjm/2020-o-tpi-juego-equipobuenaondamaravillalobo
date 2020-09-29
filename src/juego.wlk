import estaticos.*
import nivel.*
import wollok.game.*



object roger{
    var property position = game.at(3,1)

    method image() = "roger.png"
    
    method irA(nuevaPosicion){
    	position = nuevaPosicion 
    }
    method caer(altura){
		position = game.at(position.x(),0.max.position.y()-altura)
		
		
	}
}

object raqueta{
    var property position = 
    method image() = "raqueta1.png"
}


object pelota{
    var property position = 0
    method image() = "pelota.png"
    
    
	method caer(altura){
		position = game.at(position.x(),0.max.position.y()-altura)
		
		
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

