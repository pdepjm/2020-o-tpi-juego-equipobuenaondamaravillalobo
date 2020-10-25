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
	var onTickDeMovimiento
	var property estaEnMovimiento = false
	
	

	method onTickDeMovimiento() = onTickDeMovimiento
	
	method direccionHaciaDondeGolpea() = direccionHaciaDondeGolpea
	method image() = image
	
	method gravedad(){
		position = abajo.nuevaPosicion(self,1)
	}
	
	
	method saltar(){
		if(self.puedeSaltar()){
		position = arriba.nuevaPosicion(self,2)
		15.times({i => game.schedule(20,{position = arriba.nuevaPosicion(self,1)})})
		}
	}

	method puedeSaltar() = puedeSaltar
	
	method habilitarSalto(){if(self.position().y()==0) puedeSaltar = true}

	method deshabilitarSalto(){puedeSaltar = false}
     	 
//    method golpe(){}

}

object moverJugador{
	
	method moverJugadorHacia(direccion,jugador){
		
		if(jugador.estaEnMovimiento()){
			game.removeTickEvent(jugador.onTickDeMovimiento())
			game.onTick(100, jugador.onTickDeMovimiento() ,{jugador.position(direccion.nuevaPosicion(jugador,1))})
 
		}else{
			game.onTick(100, jugador.onTickDeMovimiento() ,{jugador.position(direccion.nuevaPosicion(jugador,1))})
			jugador.estaEnMovimiento(true)
	
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
	orientacion = derecha,
	onTickDeMovimiento = "Movimiento jugador")
	
const jugador2 = new Jugador(
	
	position = game.at(139,1),
	direccionHaciaDondeGolpea = izquierda,
	image= "RogerSinFondoYsinCabeza.png",
	orientacion = izquierda,
	onTickDeMovimiento = "Movimiento jugador2")
	
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
    var property position = game.at(10,25)
    var fuerzaDeSubida = 100
    var velocidad = 100
    var tipoDeGolpe = golpeAlto
    

	
	    method image() = "pelotaPenn.png"
		method gravedad(){ position = abajo.nuevaPosicion(self,1) }
		method cambiarVelocidad(nuevaVelocidad){ velocidad = nuevaVelocidad }
		method velocidad()= velocidad
		method cambiarFuerzaDeSubida(nuevaFuerza){ fuerzaDeSubida = nuevaFuerza}
		method fuerzaDeSubida()= fuerzaDeSubida
		method perderFuerzaDeSubida(fuerzaPerdida){fuerzaDeSubida -= fuerzaPerdida}

// DIRECCION DEL JUGADOR QUE GOLPEA ES LA DIRECCION LATERAL

		method direccionLateral() = jugadorQueGolpea.direccionHaciaDondeGolpea()
			
//MOVIMIENTO DE PELOTA
 /* 
		method moverse(){
    		if(self.noPasoMitadDeCancha()){
    			tipoDeGolpe.moverPelota(arriba) 	
    					
			}else{
    			tipoDeGolpe.moverPelota(abajo)
    			self.tocarPiso()		
			}
	      }*/
/* 

		method moverse(){
			    tipoDeGolpe.moverPelota(abajo)
    			self.tocarPiso()
			
		}
	 */  	
	 method moverse(){
    		if(fuerzaDeSubida > 0){
    			pelota.perderFuerzaDeSubida(30)
    			tipoDeGolpe.moverPelota(arriba) 	
    					
			}else{
    			tipoDeGolpe.bajarPelota()
    			self.tocarPiso()		
			}
	 }
    	method golpe(nuevoGolpeador){	
    		
    		piqueDePelota.detenerPique()
    		piqueDePelota.reiniciarContadorDePiques()
    		self.jugadorQueGolpea(nuevoGolpeador)
    		if(rastreadorDeContacto.estanEnZonaDeContacto(self,jugadorQueGolpea)){
    			tipoDeGolpe.golpearPelota()

        	}
        }	
		
	     method tocarPiso(){ 
			 	if(position.y()==0){ 
			  		game.removeTickEvent("Golpea pelota")
			  		
					piqueDePelota.accionar()
					piqueDePelota.sumarUnPique()
			 		}
			 	 }

		method noPasoMitadDeCancha() = position.x() > 80 and self.direccionLateral() == izquierda or position.x() < 70 and self.direccionLateral() == derecha
	
		
       }


object controladorDePelota{
	
	method moverPelota(direccionVertical){
			pelota.position(direccionVertical.nuevaPosicion( pelota , pelota.fuerzaDeSubida()/50)) 
			pelota.position(pelota.direccionLateral().nuevaPosicion( pelota , pelota.velocidad()/20)) 
		}
}


object golpeBasico{
	
	method golpearPelota(){
    		pelota.cambiarFuerzaDeSubida(150)
        	game.onTick(100,"Golpea pelota", {pelota.moverse()})
        	}
	method moverPelota(direccionVertical){controladorDePelota.moverPelota(direccionVertical)}
}

object golpeRemate{
	
	method golpearPelota(){
			pelota.cambiarVelocidad(200)
        	game.onTick(70,"Golpea pelota", {pelota.moverse()})
        	}
        	
	method moverPelota(direccionVertical){controladorDePelota.moverPelota(abajo)}
    }

object golpeAlto{
	
	method golpearPelota(){
		    pelota.cambiarFuerzaDeSubida(500)
		    pelota.cambiarVelocidad(40)
        	game.onTick(80,"Golpea pelota", {pelota.moverse()})
        	}

	method moverPelota(direccionVertical){controladorDePelota.moverPelota(direccionVertical)}
	method bajarPelota(){
			pelota.position(abajo.nuevaPosicion( pelota ,3))
			pelota.position(pelota.direccionLateral().nuevaPosicion( pelota , pelota.velocidad()/20)) 
		}
    }






                          // DECLARACION DE PIQUE DE LA PELOTA

object piqueDePelota{
	var potenciaDePique = 60
	var contadorDePiques = 0

	method reiniciarContadorDePiques(){contadorDePiques = 0}
	method sumarUnPique(){contadorDePiques += 1}
	method perderPotenciaDePique(){potenciaDePique -= 10}
	method reiniciarPotenciaDePique(){potenciaDePique = 60}

	
	method dirigirPique(){
		if(potenciaDePique > 0){
			controladorDePelota.moverPelota(arriba)
			self.perderPotenciaDePique()
		}else{
			controladorDePelota.moverPelota(abajo)
			
		}
	}

	method accionar(){ 	
			self.reiniciarPotenciaDePique()	  
			pelota.cambiarFuerzaDeSubida(50)
			game.onTick(100,"Pelota picando",{self.dirigirPique()})
}	
	method detenerPique(){
		if(contadorDePiques >= 1){
			game.removeTickEvent("Pelota picando")
		}
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
		method nuevaPosicion(objetoMovil,altura) = game.at(objetoMovil.position().x() , objetoMovil.position().y()+altura)
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












  
  