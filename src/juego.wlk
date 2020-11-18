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
	var property puntos
	const contador 
	const posicionInicial
	
	method onTickDeMovimiento(tickEvent){onTickDeMovimiento = tickEvent}
	method onTickDeMovimiento() = onTickDeMovimiento
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


        method excedeLimiteIzquierdo()= position.x()<=0
	    
	    method excedeLimiteDeRed()= position.x()>=70 and position.x()<=78
	    
	    method excedeLimiteDerecho()= position.x() >= 140
	
	    method limitarPosicionIzquierda(){
			if(self.excedeLimiteIzquierdo() ){
				position = game.at(0,position.y())
				}else if(self.excedeLimiteDeRed()){
				position = game.at(70,position.y())
          }
	    } 
	   
	    method limitarPosicionDerecha(){
	    	if(self.excedeLimiteDerecho()){
	    		position = game.at(139,position.y())
	    	}else if(self.excedeLimiteDeRed()){
	    		position = game.at(78,position.y())
	    	}
	    }
}

const jugador1 = new Jugador(
		position = game.at(3,0),
		image = "RogerSinFondoYsinCabeza.png",
		direccionHaciaDondeGolpea = derecha,
		orientacion = derecha,
		onTickDeMovimiento = "Movimiento jugador1",
		puntos= 0,
		contador = contadorJ1,
		posicionInicial = game.at(3,0)
		)
	
const jugador2 = new Jugador(
		position = game.at(139,0),
		image = "RogerSinFondoYsinCabeza2.png",
		direccionHaciaDondeGolpea = izquierda,
		orientacion = izquierda,
		onTickDeMovimiento = "Movimiento jugador2",
		puntos = 0,
		contador= contadorJ2,
		posicionInicial = game.at(139,0)
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
   		return game.at(duenio.position().x()-3,duenio.position().y()+6)
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
    	image =  "raquetaNadalBabolat.png" 
    	,duenio = jugador2	
)
	
                              // CABEZAS DE JUGADORES
                              
                              

class Cabeza{
	var cuerpo
	var property image
	
	//El if es porque quedaba mal posicionada la imagen
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
		
		
		
//EVALUAR HACER PROPERTY

		method cambiarVelocidad(nuevaVelocidad){ velocidad = nuevaVelocidad }
		method velocidad()= velocidad
		method cambiarFuerzaDeSubida(nuevaFuerza){ fuerzaDeSubida = nuevaFuerza}
		method fuerzaDeSubida()= fuerzaDeSubida
		method perderFuerzaDeSubida(fuerzaPerdida){fuerzaDeSubida -= fuerzaPerdida}
		method cambiarJugadorQueGolpea(jugadorNuevo){jugadorQueGolpea = jugadorNuevo}
		//method sumarPique(){piques+=1}
		
// DIRECCION DEL JUGADOR QUE GOLPEA ES LA DIRECCION LATERAL

		method direccionLateral() = jugadorQueGolpea.direccionHaciaDondeGolpea()
			 
// MOVIMIENTO DE PELOTA
 
	 
	 
    	method golpe(nuevoGolpeador,nuevoContrincante,tipoGolpe){	
    		

    		
    		if(rastreadorDeContacto.estanEnZonaDeContacto(self,nuevoGolpeador)){
    			
    			//reproductorDeSonidos.sonidoDeGolpe().play()
    			
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
       
       method posicionLimite()= position.x()<-1 or position.x()>138
       
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
	
	
//TOCAR EL PISO PARA PICAR	
		 
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

		method noPasoMitadDeCancha() = position.x() > 80 and self.direccionLateral() == izquierda or position.x() < 73 and self.direccionLateral() == derecha


//LA PELOTA TOCA LA RED Y VUELVE A POSICION INICIAL SIN MOVIMIENTO

		method tocarRed(){
			
      	          if(position.y() < 10){
      		           if(position.x() >= 70 and position.x() <= 80){
      		           	
 						game.removeTickEvent(tipoDeGolpe.nombre())
 						contadorDePuntos.sumarPunto(contrincante)
 						self.reiniciarPosicion()
 						jugador1.reiniciarPosicion()
 		                jugador2.reiniciarPosicion()
      }       	    
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
/*
object controladorDePelota1{
	
	method moverPelota(direccionVertical){
			pelota.position(direccionVertical.nuevaPosicion(pelota, pelota.fuerzaDeSubida()/75)) 
			pelota.position(pelota.direccionLateral().nuevaPosicion(pelota, pelota.velocidad()/40)) 
		}
}
 */



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
        	game.onTick(80, nombre, {self.moverPelota()})
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
    		if(pelota.fuerzaDeSubida() > 0){
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
/* 
object moverPelotaVerticalmente{
	method moverPelota(direccionVertical){controladorDePelota.moverPelota(direccionVertical)}
}  
                */                

                          // OBJETOS RELACIONADOS A LOS MOVIMIENTOS DE POSICIONES EN EJES 



object izquierda{
		method nuevaPosicion(objetoMovil,distancia) = game.at(objetoMovil.position().x() - distancia, objetoMovil.position().y())		
		
		method posicionRaqueta() = game.at(jugador1.position().x() - 5,jugador1.position().y())
	 
}

	
object derecha{
		method nuevaPosicion(objetoMovil,distancia) = game.at(objetoMovil.position().x() + distancia, objetoMovil.position().y())
		
		method posicionRaqueta() = game.at(jugador1.position().x() + 5,jugador1.position().y())
	 
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












  
  