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
		position = game.at(0.max(70.min(nuevaPosicion.x())),nuevaPosicion.y())
		
		//if(nuevaPosicion.x() < 0){ position = game.at(0,nuevaPosicion.y()) }
		//
		//else{
		//	position = game.at(70.min(nuevaPosicion.x()),nuevaPosicion.y())	
		//}
		
	}
	
}





object raqueta{
    // Al poner metodo posicion, hace que se ajuste cada vez que cambia la posicion de jugadorX
    	method position() = game.at(jugador.position().x()+3,jugador.position().y())
    	
    	method image() = "raquetaNadal2.png"
    	
    	method golpe(){}
}



 
	
 object pelota{

    var property position = game.at(23,10)
    var property direccionLateral = derecha
    var energia = 100
	//var piqueActual = piqueBasico
 	//var pique = false
	
	
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
		method moverseVerticalmente(direccionVertical){position = direccionVertical.nuevaPosicion( self, energia/50 )}

		method cambiarEnergia(nuevaEnergia){energia = nuevaEnergia }
		
		// Este metodo esta nasi, hace dos parabolas , la primera seria el primer pique y la segunda el segundo pique. Si pica dos veces el juego termina
		// Tendriamos que hacer que cada vez que pica dos veces empieza el nuevo punto. 
		// MOVIMIENTOPARABOLASUPREMA SERIA EL ULTIMO MOVIMIENTO ANTES DE VOLVER A PICAR LA SEGUNDA VEZ ES LO MISMO QUE MOVIMIENTO PARABOLA PERO
		// LE AGREGUÉ EL GAME.STOP()
		    
		method movimientoParabolaSuprema(x,y){
				position = game.at(position.x()+x,position.y()+y)
				game.stop()
			}
			
		method movimientoParabola(x,y){
				position = game.at(position.x()+x,position.y()+y)
			}
		
		method piquesLadoDerecho(){ 
				 
				 game.schedule(100,{self.movimientoParabola(2,4)}) 
				 game.schedule(400,{self.movimientoParabola(2,4)}) 
				 game.schedule(700,{self.movimientoParabola(2,2)})
				 game.schedule(1000,{self.movimientoParabola(2,-2)}) 
				 game.schedule(1300,{self.movimientoParabola(2,-4)}) 
				 game.schedule(1600,{self.movimientoParabola(2,-4)})
				 game.schedule(1900,{self.movimientoParabola(1,2)}) 
				 game.schedule(2200,{self.movimientoParabola(1,2)}) 
				 game.schedule(2500,{self.movimientoParabola(1,1)}) 
				 game.schedule(2800,{self.movimientoParabola(1,-1)})
				 game.schedule(3100,{self.movimientoParabola(1,-2)})
				 game.schedule(3400,{self.movimientoParabolaSuprema(1,-2)})		
				 		 
				 }
			 
			
			/* 
			method segundoPique(){ 
				 game.schedule(100,{self.movimientoParabola(1,2)}) 
				 game.schedule(300,{self.movimientoParabola(1,2)}) 
				 game.schedule(600,{self.movimientoParabola(1,1)}) 
				 game.schedule(900,{self.movimientoParabola(1,-1)})
				 game.schedule(1100,{self.movimientoParabola(1,-2)})
				 game.schedule(1300,{self.movimientoParabola(1,-2)})
			}
			*/
			
			
			
	     method tocarPiso(){ 
			 	if(position.y()==0){ 
			 	game.removeTickEvent("Golpea pelota") 
			 	self.piquesLadoDerecho()			 	
			 		}
			 	}
			  
			 
			
			
/* 
if(position.y() == 0){
pique = true 
game.removeTickEvent("Golpea pelota")
	game.onTick(100,"Post pique",{self.moverseDespuesDelPique()})
*/
		
// MOVIMIENTO DE PELOTA 


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
	
	
	     method noPasoMitadDeCancha(){
			return (position.x() > 80 && direccionLateral == izquierda) || ( position.x() < 70 && direccionLateral == derecha)
	}
	
	
	
	/* 
		method moverseDespuesDelPique(){
			    self.moverseALosLados()
    			self.moverseVerticalmente(arriba)
    */
		
		
	

}












// OBJETOS RELACIONADOS A LOS MOVIMIENTOS DE POSICIONES EN EJES 

object izquierda{
	
	method moverObjeto(objetoMovil,distancia)= game.at(objetoMovil.position().x() - distancia, objetoMovil.position().y())
		
}
	
object derecha {
		method nuevaPosicion(objetoMovil,distancia)= game.at(objetoMovil.position().x() + distancia, objetoMovil.position().y())
}

object abajo{
	    method nuevaPosicion(objetoMovil,altura)= game.at(objetoMovil.position().x(), 0.max(objetoMovil.position().y()-altura))
}

object arriba{
		method nuevaPosicion(objetoMovil,altura)= game.at(objetoMovil.position().x() , 80.min(objetoMovil.position().y()+altura))
}

/* 
object piqueBasico{
	
		method afectar(pelota){
			if(pelota.tocarPiso())
			
			pelota.cambiarEnergia(200)
			
		
	}
	
}
*/

































  
  