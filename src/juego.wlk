import estaticos.*
import nivel.*
import wollok.game.*



	
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
     	 
//    mthod golpe(){}
//FALTA VER METHOD TOCAR RED DE LOS JUGADORES DEPENDIENDO EL LADO
    /* 
    method tocarRed(){
      		           if(position.x() >= 73 and position.x() <= 77){
      		           	game.removeTickEvent(jugador.onTickDeMovimiento())
      		           	game.removeTickEvent(jugador2.onTickDeMovimiento())
      	            	direccionHaciaDondeGolpea.nuevaPosicion(self,-3)    
     } 
         	    
    }*/ 	
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
const jugador2 = new Jugador(
	
	position = game.at(139,0),
	direccionHaciaDondeGolpea = izquierda,
	image= "RogerSinFondoYsinCabeza.png",
	orientacion = izquierda,
	onTickDeMovimiento = "Movimiento jugador2")
	
	
const jugador = new Jugador(
	position = game.at(3,0),
	direccionHaciaDondeGolpea = derecha,
	image= "RogerSinFondoYsinCabeza.png",
	orientacion = derecha,
	onTickDeMovimiento = "Movimiento jugador")
	

	
const raquetaJugador = new Raqueta(	
    	image = "raquetaJugadorSinFondo.png"
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
 	
	var jugadorQueGolpea = jugador
    var property position = game.at(35,20)
    var velocidad = 100
    var property tipoDeGolpe 
    var property fuerzaDeSubida = 100


	
	    method image() = "pelotaPenn.png"
		method gravedad(){ position = abajo.nuevaPosicion(self,1) }
//EVALUAR HACER PROPERTY
		method cambiarVelocidad(nuevaVelocidad){ velocidad = nuevaVelocidad }
		method velocidad()= velocidad
		method cambiarFuerzaDeSubida(nuevaFuerza){ fuerzaDeSubida = nuevaFuerza}
		method fuerzaDeSubida()= fuerzaDeSubida
		method perderFuerzaDeSubida(fuerzaPerdida){fuerzaDeSubida -= fuerzaPerdida}
		method cambiarJugadorQueGolpea(jugadorNuevo){jugadorQueGolpea = jugadorNuevo}
		
		
//VUELVE A LA POSICION INICIAL Y REINICIA LOS TICKS
		method reiniciarPosicion(){
			  			position = game.at(10,20)
			  			game.removeTickEvent(tipoDeGolpe.nombre())
			  			}
			
		
// DIRECCION DEL JUGADOR QUE GOLPEA ES LA DIRECCION LATERAL

		method direccionLateral() = jugadorQueGolpea.direccionHaciaDondeGolpea()
			
//MOVIMIENTO DE PELOTA
 
	 
	 
    	method golpe(nuevoGolpeador,tipoGolpe){	
    		
    		
    			piqueDePelota.detenerPique()
    		piqueDePelota.reiniciarContadorDePiques()
    	    self.tipoDeGolpe(tipoGolpe)
    		self.cambiarJugadorQueGolpea(nuevoGolpeador)
    		if(rastreadorDeContacto.estanEnZonaDeContacto(self,jugadorQueGolpea)){
    			tipoGolpe.golpearPelota()
        	}	
    		}
    		
        
		
	     method tocarPiso(){ 
			 	if(position.y()==0){ 
			  		
					piqueDePelota.accionar()
					piqueDePelota.sumarUnPique()
					game.removeTickEvent(tipoDeGolpe.nombre())
			 		}
			 	 }

		method noPasoMitadDeCancha() = position.x() > 80 and self.direccionLateral() == izquierda or position.x() < 70 and self.direccionLateral() == derecha
	
		method tocarRed(){
      	          if(position.y() < 15){
      		           if(position.x() >= 70 and position.x() <= 80){
      	            	self.reiniciarPosicion()  
     } 
         	    
    } 	
   }
  
 }

//EVALUAR LLEVAR EL METHOD DEL OBJETO A LA PELOTA PARA NO REPETIR DOS VECES MOVERPELOTA()
object controladorDePelota{
	
	method moverPelota(direccionVertical){
			pelota.position(direccionVertical.nuevaPosicion(pelota, pelota.fuerzaDeSubida()/50)) 
			pelota.position(pelota.direccionLateral().nuevaPosicion(pelota , pelota.velocidad()/20)) 
		}
}


                                         //GOLPE BASICO,ALTO Y REMATE

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



                                                   //   PIQUE DE LA PELOTA

object piqueDePelota{
	var potenciaDePique = 60
	var contadorDePiques = 0

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
			
		}
	}

	method accionar(){ 	
			self.reiniciarPotenciaDePique()	  
			pelota.cambiarFuerzaDeSubida(50)
			game.onTick(150,"Pelota picando",{self.dirigirPique()})
}	
	method detenerPique(){
		if(contadorDePiques == 2){
			game.removeTickEvent("Pelota picando")
			
			//Aca en vez de poner game.stop() podriamos hacer que en pantalla se muestre el contador sumando al ganador,
			// y poner la pelota despues 3 o 5 segundos en la posicion inicial de la pelota(parecido a cuando toca la red)
			
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
		
		return (primerObjeto.position().x() - segundoObjeto.position().x()).abs() <= 3
		
		
	}
	method rangoDeContactoEnY(primerObjeto,segundoObjeto){
		
		return (primerObjeto.position().y() - segundoObjeto.position().y()).abs() <= 3
		
	}
	
	method estanEnZonaDeContacto(primerObjeto,segundoObjeto){
		
		return self.rangoDeContactoEnX(primerObjeto,segundoObjeto) and self.rangoDeContactoEnY(primerObjeto,segundoObjeto)	
	}
}












  
  