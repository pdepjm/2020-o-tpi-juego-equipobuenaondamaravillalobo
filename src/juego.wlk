import estaticos.*
import nivel.*
import wollok.game.*



object jugador{

    var property position = game.at(3,1)
//	var puedeSaltar= true
	
    method image() = "roger2.png"
    
	method gravedad(){
		position = abajo.nuevaPosicion(self,1)
	}
	method saltar(){
		position = arriba.nuevaPosicion(self, 5)
		
	}

	method irA(nuevaPosicion){
		
		if(nuevaPosicion.x() < 0){ position = game.at(0,nuevaPosicion.y()) }
		
		else{
			position = game.at(70.min(nuevaPosicion.x()),nuevaPosicion.y())	
			
		}
		
	}
	
}





object raqueta{
    
    	method position() = game.at(jugador.position().x()- 5,jugador.position().y())
    	
    	method image() = "raquetaNadal2.png"
    	
    	method golpe(){}
}



 
	
 object pelota{

    var property position = game.at(5,10)
    var direccionLateral = derecha
    var energia = 100
	var piqueActual = piqueBasico
	var pique = false
	
    	method image() = "pelotaPenn.png"

	//	method cambiarDireccionLateral(){direccionLateral = direccion * (-1)}
		
		method gravedad(){ position = abajo.nuevaPosicion(self,1) }
		
    	method golpe(){	
    		
    		//self.cambiarDireccion()
        	game.onTick(100,"Golpea pelota", {self.moverPelota()})
        	
        	}
  
		method moverseALosLados(){
			position = direccionLateral.nuevaPosicion( self, energia/20 )
		}
		method moverseVerticalmente(direccionVertical){position = direccionVertical.nuevaPosicion( self, energia/50 ) }

		method cambiarEnergia(nuevaEnergia){ energia = nuevaEnergia }
		
		method tocarPiso(){
			if(position.y() == 0){
				pique = true 
				game.removeTickEvent("Golpea pelota")
				game.onTick(100,"Post pique",{self.moverseDespuesDelPique()})
				
			}}
		
		
// moverPelota.


    	method moverPelota(){
    		
    		if(self.noPasoMitadDeCancha()){
    			
    			self.moverseALosLados()
    			self.moverseVerticalmente(arriba)
			}else{
				
    			self.moverseALosLados()
    			self.moverseVerticalmente(abajo)
    			self.tocarPiso()
			}
	}
		method moverseDespuesDelPique(){
			    self.moverseALosLados()
    			self.moverseVerticalmente(arriba)
			
		}
		method noPasoMitadDeCancha(){
			return (position.x() > 80 && direccionLateral == izquierda) || ( position.x() < 70 && direccionLateral == derecha)
	}
	

}



object izquierda{
	
	method moverObjeto(objetoMovil,distancia){
		
		return game.at(objetoMovil.position().x() - distancia, objetoMovil.position().y())
		
	}
	
	
}
object derecha {
	
		method nuevaPosicion(objetoMovil,distancia){
		
		return game.at(objetoMovil.position().x() + distancia, objetoMovil.position().y())
		
	}
	
}
object abajo{
	    method nuevaPosicion(objetoMovil,altura){
	    	
		return game.at(objetoMovil.position().x(), 0.max(objetoMovil.position().y()-altura))
		
	}
	
}

object arriba{
		
		method nuevaPosicion(objetoMovil,altura){
			
		return game.at(objetoMovil.position().x() , objetoMovil.position().y()+altura)
		
	}
}


object piqueBasico{
	
		method afectar(pelota){
			if(pelota.tocarPiso())
			
			pelota.cambiarEnergia(200)
			
		
	}
	
}


































  
  