import estaticos.*
import nivel.*
import wollok.game.*

const jugador = new Jugador(
	position = game.at(3,1),
	direccionHaciaDondeGolpea = derecha,
	image= "roger2.png",
	orientacion = derecha)
	
const jugador2 = new Jugador(
	
	position = game.at(147,1),
	direccionHaciaDondeGolpea = izquierda,
	image= "RogerSinFondoYsinCabeza.png",
	orientacion = izquierda)
	
	


class Jugador{
	var direccionHaciaDondeGolpea
	var property position
	var image 
	var property orientacion
	
	method direccionHaciaDondeGolpea() = direccionHaciaDondeGolpea
	method image() = image
	
	method gravedad(){
		position = abajo.nuevaPosicion(self,1)
	}
	
	method saltar(){
		position = arriba.nuevaPosicion(self, 5)
		
	}
	
	method irA(nuevaPosicion, unaOrientacion){
		
		orientacion = unaOrientacion
		
		position = game.at(0 .max ( 75 .min (nuevaPosicion.x ())), nuevaPosicion.y ())
		/*  
		if(nuevaPosicion.x() < 0){
			position = game.at(0,nuevaPosicion.y())
		}
		
		else{
			position = game.at(70.min(nuevaPosicion.x()),nuevaPosicion.y())
			}
	*/
}

}



object cabezaRoger{
	method position()= game.at(jugador2.position().x(),jugador2.position().y()+5)
	
	method image()= "cabezaRoger.png"
}


object raquetaJugador2{
    	
    	method position()= game.at(jugador2.position().x()-2,jugador2.position().y()+2)
    	
    //	method position() = jugador.orientacionDelJugador().posicionRaqueta()
    	
    	method image()=  "raquetaNadal2.png"
    	
    /* 	method golpe(nuevoGolpeador){	
    		
    		pelota.jugadorQueGolpea(nuevoGolpeador)
        	game.onTick(100,"Golpea pelota", {pelota.moverPelota()})
        	
}*/
}

object raquetaJugador{
    	
    	method position()= game.at(jugador.position().x()+2,jugador.position().y()+2)
    	
    //	method position() = jugador.orientacionDelJugador().posicionRaqueta()
    	
    	method image()=  "raquetaBabolat - copia.png"
    	
  /*   	method golpe(nuevoGolpeador){	
    		
    		pelota.jugadorQueGolpea(nuevoGolpeador)
        	game.onTick(100,"Golpea pelota", {pelota.moverPelota()})
        	
}*/
}
	
 object pelota{
 	
	var property jugadorQueGolpea = jugador
    var property position = game.at(23,10)
    var energia = 100

	
	    method image() = "pelotaPenn.png"
		method gravedad(){ position = abajo.nuevaPosicion(self,1) }
		method cambiarEnergia(nuevaEnergia){ energia = nuevaEnergia }
		
	
	
		method moverse(direccionVertical){
			position = direccionVertical.nuevaPosicion( self, energia/50 )
			position = self.direccionLateral().nuevaPosicion( self, energia/20 )
		}

		
		method direccionLateral() = jugadorQueGolpea.direccionHaciaDondeGolpea()
		
    	method golpe(nuevoGolpeador){	
    		if( rastreadorDeContacto.estanEnZonaDeContacto(self,jugadorQueGolpea)){
    		self.jugadorQueGolpea(nuevoGolpeador)
        	game.onTick(100,"Golpea pelota", {self.moverPelota()})
        	}
}



/*
 		method movimientoParabolaSuprema(x,y){
				position = game.at(position.x()+x,position.y()+y)
				//game.stop()
			}
			
		method movimientoParabola(x,y){
				position = game.at(position.x()+x,position.y()+y)
			}
*/		
		
		method pique(){
			self.cambiarEnergia(60)

			     game.schedule(100,{self.moverse(arriba)}) 
				 game.schedule(400,{self.moverse(arriba)}) 
				 game.schedule(700,{self.moverse(arriba)})
				 game.schedule(1000,{self.moverse(arriba)}) 
				 game.schedule(1300,{self.moverse(arriba)}) 
				 game.schedule(1600,{self.moverse(arriba)})
				 
				 game.schedule(1900,{self.moverse(abajo)}) 
				 game.schedule(2200,{self.moverse(abajo)}) 
				 game.schedule(2500,{self.moverse(abajo)}) 
				 game.schedule(2800,{self.moverse(abajo)})
				 game.schedule(3100,{self.moverse(abajo)})
				 game.schedule(3400,{self.moverse(abajo)})		
				 			
		} 
		
/* 	method pique(){ 
				 
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
				 		 
				 */
			
	     method tocarPiso(){ 
			 	if(position.y()==0){ 
			  		game.removeTickEvent("Golpea pelota") 
					self.pique()	
			 		}
			 	 }

		
// MOVIMIENTO DE PELOTA 

		method noPasoMitadDeCancha() = position.x() > 80 and self.direccionLateral() == izquierda or position.x() < 70 and self.direccionLateral() == derecha
	
		method moverPelota(){
    		
    		if(self.noPasoMitadDeCancha()){
  
    			self.moverse(arriba)
    			
			}else{
				
    			self.moverse(abajo)
    			self.tocarPiso()
    			
			}
	}
	   
}







// OBJETOS RELACIONADOS A LOS MOVIMIENTOS DE POSICIONES EN EJES 

object izquierda{
		method nuevaPosicion(objetoMovil,distancia)= game.at(objetoMovil.position().x() - distancia, objetoMovil.position().y())		
		
		method posicionRaqueta() = game.at(jugador.position().x() - 5,jugador.position().y())
}
	
object derecha{
		method nuevaPosicion(objetoMovil,distancia)= game.at(objetoMovil.position().x() + distancia, objetoMovil.position().y())
		
		method posicionRaqueta() = game.at(jugador.position().x() + 5,jugador.position().y())
}

object abajo{
	    method nuevaPosicion(objetoMovil,altura)= game.at(objetoMovil.position().x(), 0.max(objetoMovil.position().y()-altura))
}

object arriba{
		method nuevaPosicion(objetoMovil,altura)= game.at(objetoMovil.position().x() , 80.min(objetoMovil.position().y()+altura))
}





object rastreadorDeContacto{
	
	method rangoDeContactoEnX(primerObjeto,segundoObjeto){
		
		return (primerObjeto.position().x() - segundoObjeto.position().x()).abs() <= 10
		
		
	}
	method rangoDeContactoEnY(primerObjeto,segundoObjeto){
		
		return (primerObjeto.position().y() - segundoObjeto.position().y()).abs() <= 10
		
	}
	
	method estanEnZonaDeContacto(primerObjeto,segundoObjeto){
		
		return self.rangoDeContactoEnX(primerObjeto,segundoObjeto) and self.rangoDeContactoEnY(primerObjeto,segundoObjeto)	
	}
}

















  
  