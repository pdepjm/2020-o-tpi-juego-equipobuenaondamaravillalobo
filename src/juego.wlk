import estaticos.*
import nivel.*
import wollok.game.*


	// game.removeTickEvent ( " enemigo en movimiento " )
	
	
                             // CLASE DE JUGADORES

class Jugador{
	var direccionHaciaDondeGolpea
	var property position
	var image 
	var property orientacion
	var puedeSaltar= true
	
	method direccionHaciaDondeGolpea() = direccionHaciaDondeGolpea
	method image() = image
	
	method gravedad(){
		position = abajo.nuevaPosicion(self,1)
	}
	
	
	method saltar(){
		if(self.puedeSaltar()){
		position = arriba.nuevaPosicion(self,2)
		8.times({i => game.schedule(20,{position = arriba.nuevaPosicion(self,1)})})
		}
	}

	method puedeSaltar() = puedeSaltar
	
	method habilitarSalto(){if(self.position().y()==0) puedeSaltar = true}

	method deshabilitarSalto(){puedeSaltar = false}
     	 
//    method golpe(){}

}


object moverJugador{
	
	var property jugadorEstaEnMovimiento = false
	
	method moverJugadorHacia(direccion){
		
		if(self.jugadorEstaEnMovimiento()){
			game.removeTickEvent("Jugador corriendo")
			game.onTick(100,"Jugador corriendo",{jugador.position(direccion.nuevaPosicion(jugador,1))})
 
		}else{
			game.onTick(100,"Jugador corriendo",{jugador.position(direccion.nuevaPosicion(jugador,1))})
			jugadorEstaEnMovimiento = true 
	
	}
	}
}

object moverJugador2{
	
	var property jugadorEstaEnMovimiento = false
	
	method moverJugadorHacia(direccion){
		
		if(self.jugadorEstaEnMovimiento()){
			game.removeTickEvent("Jugador2 corriendo")
			game.onTick(100,"Jugador2 corriendo",{jugador2.position(direccion.nuevaPosicion(jugador2,1))})
 
		}else{
			game.onTick(100,"Jugador2 corriendo",{jugador2.position(direccion.nuevaPosicion(jugador2,1))})
			jugadorEstaEnMovimiento = true 
	
	}
	}
}






/*              
                                         
 class JugadorEstrella inherits Jugador{ 
 super()                                 
 override method golpe(){                
 */

                           // CLASE DE RAQUETAS

class Raqueta{
	
	var image
	const duenio
// PONER LA POSICION DE ESTA MANERA ME PERMITE QUE AL MOVER EL JUGADOR SE MUEVA
// SIMULTANEAMENTE LA RAQUETA.
   method position(){ 
   if(duenio.position().x()<75){  
   	return game.at(duenio.position().x()+2,duenio.position().y()+2)
   	}else{
   		return game.at(duenio.position().x()-2,duenio.position().y()+2)
   	}
    }
  
    	
   method image()=  image
    	 
//   method golpe(){}
        	
   }




// DECLARACION DE JUGADORES DISPONIBLES CON SUS RESPECTIVAS RAQUETAS
const jugador = new Jugador(
	position = game.at(3,1),
	direccionHaciaDondeGolpea = derecha,
	image= "roger2.png",
	orientacion = derecha)
	
const jugador2 = new Jugador(
	
	position = game.at(139,1),
	direccionHaciaDondeGolpea = izquierda,
	image= "RogerSinFondoYsinCabeza.png",
	orientacion = izquierda)
	
const raquetaJugador = new Raqueta(	
    	image = "raquetaBabolat - copia.png"
    	,duenio = jugador    	
)

const raquetaJugador2 = new Raqueta(
    	image =  "raquetaNadal2.png" 
    	,duenio = jugador2	
)
	






                              // CABEZAS DE JUGADORES

object cabezaRoger{
	method position()= game.at(jugador2.position().x(),jugador2.position().y()+9)
	
	method image()= "cabezaRoger.png"
}



                           // DECLARACION DE LA PELOTA 
	
 object pelota{
 	
	var property jugadorQueGolpea = jugador
    var property position = game.at(45,10)
    var energia = 100
    var tipoDeGolpe = golpeBasico

	
	    method image() = "pelotaPenn.png"
		method gravedad(){ position = abajo.nuevaPosicion(self,1) }
		method cambiarEnergia(nuevaEnergia){ energia = nuevaEnergia }
		method energia()= energia
	
		method moverse(direccionVertical){
			position = direccionVertical.nuevaPosicion( self, energia/50 )
			position = self.direccionLateral().nuevaPosicion( self, energia/20 )
		}

// DIRECCION DEL JUGADOR QUE GOLPEA ES LA DIRECCION LATERAL

		method direccionLateral() = jugadorQueGolpea.direccionHaciaDondeGolpea()
			
//MOVIMIENTO DE PELOTA SEGUN SI PASO MITAD DE CANCHA
		
		method moverPelota(){
    		if(self.noPasoMitadDeCancha()){
    			self.moverse(arriba) 	
    					
			}else{
    			self.moverse(abajo)
    			self.tocarPiso()		
			}
	      }
	   	
    	method golpe(nuevoGolpeador){	
    		
    		self.jugadorQueGolpea(nuevoGolpeador)
    		if(rastreadorDeContacto.estanEnZonaDeContacto(self,jugadorQueGolpea)){
    			tipoDeGolpe.golpearPelota()

        	}
        }	
			
	     method tocarPiso(){ 
			 	if(position.y()==0){ 
			  		game.removeTickEvent("Golpea pelota") 
					piqueDePelota.accionar()	
			 		}
			 	 }

		method noPasoMitadDeCancha() = position.x() > 80 and self.direccionLateral() == izquierda or position.x() < 70 and self.direccionLateral() == derecha
	
		
       }


object golpeBasico{
	
	method golpearPelota(){
    		pelota.cambiarEnergia(150)
        	game.onTick(100,"Golpea pelota", {pelota.moverPelota()})
        	}
        }	


object golpeDebil{
	
	method golpearPelota(){}
}

object golpeAlto{
	
	method golpearPelota(){}
}





                          // DECLARACION DE PIQUE DE LA PELOTA

object piqueDePelota{
	
	
	method accionar(){ 
		  
			pelota.cambiarEnergia(60)

			     game.schedule(100,{pelota.moverse(arriba)}) 
				 game.schedule(400,{pelota.moverse(arriba)}) 
				 game.schedule(700,{pelota.moverse(arriba)})
				 game.schedule(1000,{pelota.moverse(arriba)}) 
				 game.schedule(1300,{pelota.moverse(arriba)}) 
				 game.schedule(1600,{pelota.moverse(arriba)})
				 
				 game.schedule(1900,{pelota.moverse(abajo)}) 
				 game.schedule(2200,{pelota.moverse(abajo)}) 
				 game.schedule(2500,{pelota.moverse(abajo)}) 
				 game.schedule(2800,{pelota.moverse(abajo)})
				 game.schedule(3100,{pelota.moverse(abajo)})
				 game.schedule(3400,{pelota.moverse(abajo)})		
				 			
		} 
}	




                            // OBJETOS RELACIONADOS A LOS MOVIMIENTOS DE POSICIONES EN EJES 

object izquierda{
		method nuevaPosicion(objetoMovil,distancia) = game.at(objetoMovil.position().x() - distancia, objetoMovil.position().y())		
		
		method posicionRaqueta() = game.at(jugador.position().x() - 5,jugador.position().y())
}
	
object derecha{
		method nuevaPosicion(objetoMovil,distancia) = game.at(objetoMovil.position().x() + distancia, objetoMovil.position().y())
		
		method posicionRaqueta() = game.at(jugador.position().x() + 5,jugador.position().y())
}

object abajo{
	    method nuevaPosicion(objetoMovil,altura) = game.at(objetoMovil.position().x(), 0.max(objetoMovil.position().y()-altura))
}

object arriba{
		method nuevaPosicion(objetoMovil,altura) = game.at(objetoMovil.position().x() , 25.min(objetoMovil.position().y()+altura))
}







           // DECLARACION DE OBJETOS PARA RELACIONAR DISTANCIA DE PELOTA CON RAQUETA

object rastreadorDeContacto{
	
	method rangoDeContactoEnX(primerObjeto,segundoObjeto){
		
		return (primerObjeto.position().x() - segundoObjeto.position().x()).abs() <= 5
		
		
	}
	method rangoDeContactoEnY(primerObjeto,segundoObjeto){
		
		return (primerObjeto.position().y() - segundoObjeto.position().y()).abs() <= 5
		
	}
	
	method estanEnZonaDeContacto(primerObjeto,segundoObjeto){
		
		return self.rangoDeContactoEnX(primerObjeto,segundoObjeto) and self.rangoDeContactoEnY(primerObjeto,segundoObjeto)	
	}
}












  
  