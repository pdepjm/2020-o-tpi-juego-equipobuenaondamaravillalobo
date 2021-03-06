import estaticos.*
import nivel.*
import wollok.game.*
import menu.*


const mitadDeCanchaDerecha = 76
const mitadDeCanchaIzquierda = 73

                             // CLASE DE JUGADORES

class Jugador{
	var property direccionHaciaDondeGolpea
	var property position
	var property image 
	var property orientacion
	var puedeSaltar= true
	var property onTickName
	var property estaEnMovimiento = false
	var property puntos
	const contador 
	const posicionInicial
	
	
	method direccionHaciaDondeGolpea() = direccionHaciaDondeGolpea
	method image() = image
	method contador() = contador
	method gravedad(){position = abajo.nuevaPosicion(self,1)}
	method puedeSaltar() = puedeSaltar
    method habilitarSalto(){if(self.position().y()==0) puedeSaltar = true}
	method deshabilitarSalto(){puedeSaltar = false}
	method reiniciarPosicion(){position = posicionInicial}
	
	

	method saltar(){
		if(self.puedeSaltar()){
		position = arriba.nuevaPosicion(self,2)
		15.times({i => game.schedule(20,{position = arriba.nuevaPosicion(self,1)})})
		}
	    } 
	    
 
        method excedeLimiteIzquierdo()= position.x() <= izquierda.limiteDeCancha()
	    
	    method excedeLimiteDerecho()= position.x() >= derecha.limiteDeCancha()
	    
	    method excedeLimiteDeRed()= red.rangoDeRed(position.x(), position.y())
	
		method excedeAlgunLimite() = self.excedeLimiteIzquierdo() || self.excedeLimiteDeRed() || self.excedeLimiteDerecho()
		
	    method limitarPosicion(){
			if(self.excedeAlgunLimite()){
				
				game.removeTickEvent("limitarPosicion")
				game.removeTickEvent(self.onTickName())
				self.estaEnMovimiento(false)	
          }
	    }

}
const jugador1 = new Jugador(
		position = game.at(3,0),
		image = "RogerSinFondoYsinCabeza.png",
		direccionHaciaDondeGolpea = derecha,
		orientacion = derecha,
		onTickName= "Movimiento jugador1",
		puntos= 0,
		contador = contadorJ1,
		posicionInicial = game.at(3,0)
		)
	
const jugador2 = new Jugador(
		position = game.at(138,0),
		image = "RogerSinFondoYsinCabeza2.png",
		direccionHaciaDondeGolpea = izquierda,
		orientacion = izquierda,
		onTickName = "Movimiento jugador2",
		puntos = 0,
		contador= contadorJ2,
		posicionInicial = game.at(139,0)
		)	

     		
   
object moverJugador{
	
	method moverJugadorHacia(direccion,jugador){
		
		if(jugador.estaEnMovimiento()){
			game.removeTickEvent(jugador.onTickName())

			game.onTick(100, jugador.onTickName() ,{jugador.position(direccion.nuevaPosicion(jugador,1))})
		}else{
			game.onTick(100, jugador.onTickName() ,{jugador.position(direccion.nuevaPosicion(jugador,1))})
			jugador.estaEnMovimiento(true)		
	    }
	    game.onTick(100,"limitarPosicion",{jugador.limitarPosicion()})
	    
	}

	}


                           // CLASE DE RAQUETAS

class Raqueta{
	
	var image
	const duenio
   method position(){ 
   if(duenio.position().x()<72){  
   	return game.at(duenio.position().x()+4,duenio.position().y()+6)
   	}else{
   		return game.at(duenio.position().x()-3,duenio.position().y()+6)
   	}
}
   	
   method image()=  image
        	
   }
	
const raquetaJugador = new Raqueta(	
    	image = "raquetaJugadorSinFondo.png"
    	,duenio = jugador1    	
)

const raquetaJugador2 = new Raqueta(
    	image =  "raquetaNadalBabolat.png" 
    	,duenio = jugador2	
)
	
                              // CABEZAS DE JUGADORES
                              
                              

class Cabeza{
	var cuerpo
	var property image
	

	method position()=
	if(cuerpo == jugador2)
	return game.at(cuerpo.position().x()+1,cuerpo.position().y()+6)
	else
	return game.at(cuerpo.position().x()-3,cuerpo.position().y()+6)
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
    var property position = game.at(10,30)
    var velocidad = 100
    var property tipoDeGolpe = golpeNulo
    var property fuerzaDeSubida = 100
    
    
	
	    method image() = "pelotaPenn1.png"
		method gravedad(){ position = abajo.nuevaPosicion(self,1) }
		
		
		

		method tieneFuerzaDeSubida() = fuerzaDeSubida > 0 
		method cambiarVelocidad(nuevaVelocidad){ velocidad = nuevaVelocidad }
		method velocidad()= velocidad
		method cambiarFuerzaDeSubida(nuevaFuerza){ fuerzaDeSubida = nuevaFuerza}
		method fuerzaDeSubida()= fuerzaDeSubida
		method perderFuerzaDeSubida(fuerzaPerdida){fuerzaDeSubida -= fuerzaPerdida}
		method cambiarJugadorQueGolpea(jugadorNuevo){jugadorQueGolpea = jugadorNuevo}
	
		
// DIRECCION DEL JUGADOR QUE GOLPEA ES LA DIRECCION LATERAL

		method direccionLateral() = jugadorQueGolpea.direccionHaciaDondeGolpea()
			 
// MOVIMIENTO DE PELOTA
	 
    	method golpe(nuevoGolpeador,nuevoContrincante,tipoGolpe){	
    		

    		
    		if(rastreadorDeContacto.estanEnZonaDeContacto(self,nuevoGolpeador)){
    	
    			piqueDePelota.detenerPique()
    			piqueDePelota.reiniciarContadorDePiques()
 				game.removeTickEvent(self.tipoDeGolpe().nombre())
    			self.tipoDeGolpe(tipoGolpe)
    			self.jugadorQueGolpea(nuevoGolpeador)
    			self.contrincante(nuevoContrincante)
    		
    			tipoGolpe.golpearPelota()
        	}	
    	}
    	
    	
//LIMITES 1<POSICION<150
       
       method posicionLimite() = position.x() < izquierda.limiteDeCancha() or position.x() > derecha.limiteDeCancha()
       
       method limitarPosicion(){
 	     if(self.posicionLimite()){
 	      if(piqueDePelota.contadorDePiques()!=0){
 	    	contadorDePuntos.sumarPunto(jugadorQueGolpea)
 			self.reiniciarPosicion()
 			jugador1.reiniciarPosicion()
 		    jugador2.reiniciarPosicion()
 			piqueDePelota.reiniciarContadorDePiques()
 			game.removeTickEvent("Pelota picando")
 		}else{
 			contadorDePuntos.sumarPunto(contrincante)
 		    piqueDePelota.reiniciarContadorDePiques()
 		    game.removeTickEvent(tipoDeGolpe.nombre())
 		    self.reiniciarPosicion()
 		    jugador1.reiniciarPosicion()
 		    jugador2.reiniciarPosicion()
 		}
    }
}


    		
 //VUELVE A LA POSICION INICIAL Y REINICIA LOS TICKS
 
		method reiniciarPosicion(){
						self.tipoDeGolpe(golpeNulo)
						golpeNulo.golpearPelota()
						
			  			position = game.at(10,30)
			  	}        
	
	
//TOCAR EL PISO 
		 
		 method tocarPiso(){ 
			 	if(position.y()==0){
			 			game.removeTickEvent(tipoDeGolpe.nombre())
			 			self.tipoDeGolpe(golpeNulo)
			 			golpeNulo.golpearPelota()
			 			
			 		if(self.noPasoMitadDeCancha()){
			 			contadorDePuntos.sumarPunto(contrincante)
			 			self.reiniciarPosicion()
			 			 jugador1.reiniciarPosicion()
 		                 jugador2.reiniciarPosicion()
			 		
			 		}else{
			  			piqueDePelota.sumarUnPique()
			  			piqueDePelota.accionar()
			 	}
			}
		}	
			

//PASAR MITAD DE CANCHA

		method noPasoMitadDeCancha() = position.x() > mitadDeCanchaIzquierda and self.direccionLateral() == izquierda or position.x() < mitadDeCanchaDerecha and self.direccionLateral() == derecha


//LA PELOTA TOCA LA RED Y VUELVE A POSICION INICIAL SIN MOVIMIENTO

		method tocarRed(){
				  if(red.rangoDeRed(position.x(),position.y())){
 						game.removeTickEvent(tipoDeGolpe.nombre())
 						contadorDePuntos.sumarPunto(contrincante)
 						self.reiniciarPosicion()
 						jugador1.reiniciarPosicion()
 		                jugador2.reiniciarPosicion()
      }       	    
    } 

	method doblePique(){
		if(piqueDePelota.contadorDePiques() >= 2){
      		    contadorDePuntos.sumarPunto(jugadorQueGolpea)
 				game.removeTickEvent("Pelota picando")
 				piqueDePelota.reiniciarContadorDePiques()
				self.reiniciarPosicion()	
				jugador1.reiniciarPosicion()
 		        jugador2.reiniciarPosicion()
		}
	}
}



                      //CONTROLADOR DE PELOTA EN X E Y SEGUN FUERZA DE SUBIDA Y VELOCIDAD
                      
object controladorDePelota{
	
	method moverPelota(direccionVertical){
			pelota.position(direccionVertical.nuevaPosicion(pelota, pelota.fuerzaDeSubida()/50)) 
			pelota.position(pelota.direccionLateral().nuevaPosicion(pelota, pelota.velocidad()/20)) 
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
	method tienePotencia() = potenciaDePique > 0

	method dirigirPique(){	
		if(self.tienePotencia()){
			self.perderPotenciaDePique()
			controladorDePelota.moverPelota(arriba)
			}else{
			controladorDePelota.moverPelota(abajo)
			if(pelota.position().y()==0){
				self.sumarUnPique()
			}
		}
	}

	method accionar(){ 	
			self.reiniciarPotenciaDePique()	  
			pelota.cambiarFuerzaDeSubida(75)
			game.onTick(150,"Pelota picando",{self.dirigirPique()})
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
	const nombre = "golpeBasico"
	   
	    method nombre()= nombre
	    
	    method golpearPelota(){
    		pelota.cambiarFuerzaDeSubida(100)
    		
    		pelota.cambiarVelocidad(100)
        	game.onTick(70, nombre, {self.moverPelota()})
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
	const nombre = "golpeRemate"
	
	method nombre()= nombre
	
	method golpearPelota(){
			pelota.cambiarVelocidad(200)
			pelota.cambiarFuerzaDeSubida(100)
        	game.onTick(70,nombre, {self.moverPelota()})
        	}
  
	
	method moverPelota(){
 				
    			controladorDePelota.moverPelota(abajo)
    			pelota.tocarPiso()		
			}
    }



//GOLPE ALTO

object golpeAlto{
	const nombre = "golpeAlto"
	
	method nombre()= nombre
	
	 method golpearPelota(){

		    pelota.cambiarFuerzaDeSubida(500)
		    pelota.cambiarVelocidad(40)
        	game.onTick(70, nombre , {self.moverPelota()})
        	}

	method bajarPelota () {
			pelota.position (abajo.nuevaPosicion (pelota, 3 ))
			pelota.position (pelota.direccionLateral (). nuevaPosicion (pelota, pelota.velocidad () / 20 ))
		}
		
					
	 method moverPelota(){
    		if(pelota.tieneFuerzaDeSubida()){
    		   pelota.perderFuerzaDeSubida(30)
    		   controladorDePelota.moverPelota(arriba) 
    		 	
			}else{
    		   pelota.tipoDeGolpe().bajarPelota()
    		   pelota.tocarPiso()		
    		
			}
	 }
	 	
}            
//GOLPE SAQUE
object golpeNulo{
	
	const nombre = "golpeNulo"
	method nombre()= nombre
	method golpearPelota(){game.onTick(70, nombre , {self.moverPelota()}) }
    method moverPelota(){}
	
	
}
              

                          // OBJETOS RELACIONADOS A LOS MOVIMIENTOS DE POSICIONES EN EJES 



object izquierda{
		method nuevaPosicion(objetoMovil,distancia) = game.at(objetoMovil.position().x() - distancia, objetoMovil.position().y())		
		
		method posicionRaqueta() = game.at(jugador1.position().x() - 5,jugador1.position().y())
	 	
	 	method limiteDeCancha() = -1
}

	
object derecha{
		method nuevaPosicion(objetoMovil,distancia) = game.at(objetoMovil.position().x() + distancia, objetoMovil.position().y())
		
		method posicionRaqueta() = game.at(jugador1.position().x() + 5,jugador1.position().y())
		
	 	method limiteDeCancha() = 139
}

object abajo{
	    method nuevaPosicion(objetoMovil,altura) = game.at(objetoMovil.position().x(), 0.max(objetoMovil.position().y()-altura))
}

object arriba{
		method nuevaPosicion(objetoMovil,altura) = game.at(objetoMovil.position().x() , objetoMovil.position().y()+altura)
}








                     // OBJETOS PARA RELACIONAR DISTANCIA DE PELOTA CON JUGADORES
const rangoDeContactoEnY = 13
const rangoDeContactoEnX = 5
object rastreadorDeContacto{
	
	method rangoDeContactoEnX(primerObjeto,segundoObjeto){
		
		return (primerObjeto.position().x() - segundoObjeto.position().x()).abs() <= rangoDeContactoEnX
		
		
	}
	method rangoDeContactoEnY(primerObjeto,segundoObjeto){
		
		return (primerObjeto.position().y() - segundoObjeto.position().y()).abs() <= rangoDeContactoEnY
		
	}
	
	method estanEnZonaDeContacto(primerObjeto,segundoObjeto){
		
		return self.rangoDeContactoEnX(primerObjeto,segundoObjeto) and self.rangoDeContactoEnY(primerObjeto,segundoObjeto)	
	}
}












  
  