import estaticos.*
import nivel.*
import wollok.game.*
import menu.*



	
                             // CLASE DE JUGADORES

class Jugador{
	var property direccionHaciaDondeGolpea
	var property position
	var property image 
	var property orientacion
	var puedeSaltar= true
	var onTickDeMovimiento
	var property estaEnMovimiento = false
	var property puntos = 0
	
	method onTickDeMovimiento(tickEvent){onTickDeMovimiento = tickEvent}
	method onTickDeMovimiento() = onTickDeMovimiento
	method direccionHaciaDondeGolpea() = direccionHaciaDondeGolpea
	method image() = image
	method gravedad(){position = abajo.nuevaPosicion(self,1)}
	method puedeSaltar() = puedeSaltar
    method habilitarSalto(){if(self.position().y()==0) puedeSaltar = true}
	method deshabilitarSalto(){puedeSaltar = false}
	method sumarPunto(){puntos+=1}
	

	method saltar(){
		if(self.puedeSaltar()){
		position = arriba.nuevaPosicion(self,2)
		15.times({i => game.schedule(20,{position = arriba.nuevaPosicion(self,1)})})
		}
	} 
}

const jugador1 = new Jugador(
		position = game.at(3,0),
		image = "RogerSinFondoYsinCabeza.png",
		direccionHaciaDondeGolpea = derecha,
		orientacion = derecha,
		onTickDeMovimiento = "Movimiento jugador1"
		)
	
const jugador2 = new Jugador(
		position = game.at(139,0),
		image = "RogerSinFondoYsinCabeza2.png",
		direccionHaciaDondeGolpea = izquierda,
		orientacion = izquierda,
		onTickDeMovimiento = "Movimiento jugador2"
		)	

     	 
//    method golpe(){}
//FALTA VER METHOD TOCAR RED DE LOS JUGADORES DEPENDIENDO EL LADO
    /* 
    method tocarRed(){
      		           if(position.x() >= 73 and position.x() <= 77){
      		           	game.removeTickEvent(jugador.onTickDeMovimiento())
      		           	game.removeTickEvent(jugador2.onTickDeMovimiento())
      	            	direccionHaciaDondeGolpea.nuevaPosicion(self,-3)    
     } 
         	    
    }*/ 	
   
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
   method position(){ 
   if(duenio.position().x()<75){  
   	return game.at(duenio.position().x()+4,duenio.position().y()+6)
   	}else{
   		return game.at(duenio.position().x()-2,duenio.position().y()+2)
   	}
}
  
    	
   method image()=  image
    	 
// method golpe(){}
        	
   }
	
const raquetaJugador = new Raqueta(	
    	image = "raquetaJugadorSinFondo.png"
    	,duenio = jugador1    	
)

const raquetaJugador2 = new Raqueta(
    	image =  "raquetaNadal2.png" 
    	,duenio = jugador2	
)
	
                              // CABEZAS DE JUGADORES
                              
                              

class Cabeza{
	var cuerpo
	var property image
	
	method position()=game.at(cuerpo.position().x(),cuerpo.position().y()+9)
}

const cabeza1 = new Cabeza(
	image = null,
	cuerpo = jugador1
)
const cabeza2 = new Cabeza(
	image = null,
	cuerpo = jugador2
)
	



                           // DECLARACION DE LA PELOTA 
	
 object pelota{
 	
	var property jugadorQueGolpea = jugador1
	var property contrincante
    var property position = game.at(35,20)
    var velocidad = 100
    var property tipoDeGolpe 
    var property fuerzaDeSubida = 100
    var property piques = 0
    
    


	
	    method image() = "pelotaPenn1.png"
		method gravedad(){ position = abajo.nuevaPosicion(self,1) }
		
//EVALUAR HACER PROPERTY

		method cambiarVelocidad(nuevaVelocidad){ velocidad = nuevaVelocidad }
		method velocidad()= velocidad
		method cambiarFuerzaDeSubida(nuevaFuerza){ fuerzaDeSubida = nuevaFuerza}
		method fuerzaDeSubida()= fuerzaDeSubida
		method perderFuerzaDeSubida(fuerzaPerdida){fuerzaDeSubida -= fuerzaPerdida}
		method cambiarJugadorQueGolpea(jugadorNuevo){jugadorQueGolpea = jugadorNuevo}
		method sumarPique(){piques+=1}
		
// DIRECCION DEL JUGADOR QUE GOLPEA ES LA DIRECCION LATERAL

		method direccionLateral() = jugadorQueGolpea.direccionHaciaDondeGolpea()
			 
// MOVIMIENTO DE PELOTA
 
	 
	 
    	method golpe(nuevoGolpeador,nuevoContrincante,tipoGolpe){	
    		
    		self.tipoDeGolpe(tipoGolpe)
    		
    		piqueDePelota.detenerPique()
    		piqueDePelota.reiniciarContadorDePiques()
    		
    		self.contrincante(nuevoContrincante)
    		self.jugadorQueGolpea(nuevoGolpeador)
    		
    		if(rastreadorDeContacto.estanEnZonaDeContacto(self,jugadorQueGolpea)){
    			tipoGolpe.golpearPelota()
    			self.piques(0)
        	}	
    	}
//LIMITES 1<POSICION<150
 
 method limitarPosicion(){
 	if(position.x()<-1 or position.x()>150){
 		if(piqueDePelota.contadorDePiques()!=0){
 		self.reiniciarPosicion()
 		jugadorQueGolpea.sumarPunto()
 		game.removeTickEvent("Pelota picando")
 		
 		}else{
 		self.reiniciarPosicion()	
 	    contrincante.sumarPunto()
 		game.removeTickEvent("Pelota picando")
 			
 		}
 	}
 }

    		
 //VUELVE A LA POSICION INICIAL Y REINICIA LOS TICKS
 
		method reiniciarPosicion(){
			  			position = game.at(10,30)
			  			jugador2.position(game.at(139,0))
			  			jugador1.position(game.at(3,0))
			  			game.removeTickEvent(tipoDeGolpe.nombre()) //No lo remueve
			  			
			  	}        
	
	
//TOCAR EL PISO PARA PICAR	
		
		 method tocarPiso(){ 
			 	if(position.y()==0){ 
			  		if(piques==0){
			  			piqueDePelota.sumarUnPique()
			  			piqueDePelota.accionar()
					    game.removeTickEvent(tipoDeGolpe.nombre())
			  		}
			 	}
			}

//PASAR MITAD DE CANCHA

		method noPasoMitadDeCancha() = position.x() > 80 and self.direccionLateral() == izquierda or position.x() < 70 and self.direccionLateral() == derecha
	
	
	
	
	
	
//LA PELOTA TOCA LA RED Y VUELVE A POSICION INICIAL SIN MOVIMIENTO

		method tocarRed(){
      	          if(position.y() < 11){
      		           if(position.x() >= 73 and position.x() <= 77){
      	            	self.reiniciarPosicion()
      	            	contrincante.sumarPunto()
      }       	    
    } 	
  }
}



                      //CONTROLADOR DE PELOTA EN X E Y SEGUN FUERZA DE SUBIDA Y VELOCIDAD
                      
object controladorDePelota{
	
	method moverPelota(direccionVertical){
			pelota.position(direccionVertical.nuevaPosicion(pelota, pelota.fuerzaDeSubida()/50)) 
			pelota.position(pelota.direccionLateral().nuevaPosicion(pelota , pelota.velocidad()/20)) 
		}
}




                               //PIQUE DE LA PELOTA

object piqueDePelota{
	var potenciaDePique = 60
	var property contadorDePiques = 0

	method reiniciarContadorDePiques(){contadorDePiques = 0}
	method sumarUnPique(){contadorDePiques += 1}
	method perderPotenciaDePique(){potenciaDePique -= 10}
	method reiniciarPotenciaDePique(){potenciaDePique = 60}

	method dirigirPique(){	
		if(potenciaDePique > 0){
			self.perderPotenciaDePique()
			controladorDePelota.moverPelota(arriba)
			}else{
			controladorDePelota.moverPelota(abajo)
			self.evaluarPunto()
			//pelota.sumarPique()
			
		}
	}
// Este metodo funciona para evaluar cuando pica por segunda vez, ya que se usaria en el metodo dirigirPique() solo cuando esta bajando

                                                                      
    method evaluarPunto(){
    	if(pelota.position().y()==0){
    			    game.removeTickEvent("Pelota picando")
			    game.removeTickEvent(pelota.tipoDeGolpe().nombre())
				pelota.jugadorQueGolpea().sumarPunto()
				pelota.reiniciarPosicion()
				pelota.piques(0)
			   
			}
    }
    
    
	method accionar(){ 	
			self.reiniciarPotenciaDePique()	  
			pelota.cambiarFuerzaDeSubida(75)
			game.onTick(150,"Pelota picando",{self.dirigirPique() /*self.evaluarPunto()*/})
}	

	method detenerPique(){
		if(contadorDePiques >=1){
			game.removeTickEvent("Pelota picando")
			}
			
}
 
}


                                         //GOLPE BASICO,ALTO Y REMATE

// GOLPE BASICO
                                         
object golpeBasico{
	const nombre = "GolpeBasico"
	   
	    method nombre()= nombre
	    
	    method golpearPelota(){
    		pelota.cambiarFuerzaDeSubida(150)
        	game.onTick(100, nombre, {self.moverPelota()})
        	}
	method moverPelota(direccionVertical){controladorDePelota.moverPelota(direccionVertical)}
	
	method moverPelota(){
    		if(pelota.noPasoMitadDeCancha()){
    			self.moverPelota(arriba) 
    			
    					
			}else{
    			self.moverPelota(abajo)
    			pelota.tocarPiso()		
			}
    }

}               

//GOLPE REMATE

object golpeRemate{
	const nombre = "GolpeRemate"
	method nombre()= nombre
	method golpearPelota(){
			pelota.cambiarVelocidad(200)
        	game.onTick(70,nombre, {self.moverPelota()})
        	}
  
	
	method moverPelota(){
    		if(pelota.noPasoMitadDeCancha()){
    			   moverPelotaVerticalmente.moverPelota(arriba) 			
			}else{
				pelota.cambiarVelocidad(100)
    			moverPelotaVerticalmente.moverPelota(abajo)
    			pelota.tocarPiso()		
			}
    }
}


//GOLPE ALTO

object golpeAlto{
	const nombre = "GolpeAlto"
	method nombre()= nombre
	 method golpearPelota(){
		    pelota.cambiarFuerzaDeSubida(500)
		    pelota.cambiarVelocidad(40)
        	game.onTick(80,nombre, {self.moverPelota()})
        	}

	method bajarPelota () {
			pelota.position (abajo.nuevaPosicion (pelota, 3 ))
			pelota.position (pelota.direccionLateral (). nuevaPosicion (pelota, pelota.velocidad () / 20 ))
		}
		
					
	 method moverPelota(){
    		if(pelota.fuerzaDeSubida() > 0){
    		   pelota.perderFuerzaDeSubida(30)
    		   moverPelotaVerticalmente.moverPelota(arriba) 
    		 	
    					
			}else{
    		   pelota.tipoDeGolpe().bajarPelota()
    		   pelota.tocarPiso()		
    		
			}
	 }	
}            

object moverPelotaVerticalmente{
	method moverPelota(direccionVertical){controladorDePelota.moverPelota(direccionVertical)}
}  
/* 
class Golpe{
	var nombre = "GolpeBasico"
	   
	    method nombre()= nombre
	    
	    method golpearPelota(){
    		pelota.cambiarFuerzaDeSubida(150)
        	game.onTick(100, nombre, {self.moverPelota()})
        	}
	method moverPelota(direccionVertical){controladorDePelota.moverPelota(direccionVertical)}
	
	method moverPelota(){
    		if(pelota.noPasoMitadDeCancha()){
    			pelota.tipoDeGolpe().moverPelota(arriba) 
    			
    					
			}else{
    			pelota.tipoDeGolpe().moverPelota(abajo)
    			pelota.tocarPiso()		
			}
    }
}

class GolpeRemate inherits Golpe{

	
	override method golpearPelota(){
			pelota.cambiarVelocidad(200)
        	game.onTick(70,"GolpeRemate", {self.moverPelota()})
        	}
    }



class GolpeAlto inherits Golpe{ 
	
	override method golpearPelota(){
		    pelota.cambiarFuerzaDeSubida(500)
		    pelota.cambiarVelocidad(40)
        	game.onTick(80,nombre, {self.moverPelota()})
        	}

	method bajarPelota(){
			pelota.position(abajo.nuevaPosicion( pelota ,3))
			pelota.position(pelota.direccionLateral().nuevaPosicion( pelota , pelota.velocidad()/20)) 
		}
				
	override method moverPelota(){
    		if(pelota.fuerzaDeSubida() > 0){
    		   pelota.perderFuerzaDeSubida(30)
    		   pelota.tipoDeGolpe().moverPelota(arriba) 
    		 	
    					
			}else{
    		   pelota.tipoDeGolpe().bajarPelota()
    		   pelota.tocarPiso()		
    		
			}
	 }	
}


const golpeBasico = new Golpe()
const golpeRemate= new GolpeRemate(nombre="GolpeRemate")
const golpeAlto = new GolpeAlto(nombre= "GolpeAlto")
*/


                                            




                          // OBJETOS RELACIONADOS A LOS MOVIMIENTOS DE POSICIONES EN EJES 



object izquierda{
		method nuevaPosicion(objetoMovil,distancia) = game.at(objetoMovil.position().x() - distancia, objetoMovil.position().y())		
		
		method posicionRaqueta() = game.at(jugador1.position().x() - 5,jugador1.position().y())
	 
	 /*method limitarPosicion(jugador1){	
			if(jugador1.position().x()<76){
				jugador1.position(game.at(77,jugador1.position().y()))
				}else if(jugador1.position().x()>145){
					jugador1.position(game.at(144,jugador1.position().y()))
        }				
	}*/	
}

	
object derecha{
		method nuevaPosicion(objetoMovil,distancia) = game.at(objetoMovil.position().x() + distancia, objetoMovil.position().y())
		
		method posicionRaqueta() = game.at(jugador1.position().x() + 5,jugador1.position().y())
	
	    method limitarPosicion(jugador1){
			if(jugador1.position().x()<=0){
				jugador1.position(game.at(0,jugador1.position().y()))
				}else if(jugador1.position().x()>=74){
				jugador1.position(game.at(74,jugador1.position().y()))
          }
	 }
}

object abajo{
	    method nuevaPosicion(objetoMovil,altura) = game.at(objetoMovil.position().x(), 0.max(objetoMovil.position().y()-altura))
}

object arriba{
		method nuevaPosicion(objetoMovil,altura) = game.at(objetoMovil.position().x() , objetoMovil.position().y()+altura)
}








                     // OBJETOS PARA RELACIONAR DISTANCIA DE PELOTA CON JUGADORES

object rastreadorDeContacto{
	
	method rangoDeContactoEnX(primerObjeto,segundoObjeto){
		
		return (primerObjeto.position().x() - segundoObjeto.position().x()).abs() <= 5
		
		
	}
	method rangoDeContactoEnY(primerObjeto,segundoObjeto){
		
		return (primerObjeto.position().y() - segundoObjeto.position().y()).abs() <= 13
		
	}
	
	method estanEnZonaDeContacto(primerObjeto,segundoObjeto){
		
		return self.rangoDeContactoEnX(primerObjeto,segundoObjeto) and self.rangoDeContactoEnY(primerObjeto,segundoObjeto)	
	}
}












  
  