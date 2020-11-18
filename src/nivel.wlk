import juego.*
import estaticos.*
import wollok.game.*
import menu.*


// DECLARACION DE JUGADORES DISPONIBLES CON SUS RESPECTIVAS RAQUETAS


object partido{
	
		method iniciar(){
		
		game.clear()	
// OBJETOS MOSTRADOS POR PANTALLA
                                                 
		
		game.addVisual(jugador1)
		game.addVisual(jugador2)
		game.addVisual(cabeza1)
		game.addVisual(cabeza2)
		game.addVisual(pelota)
		game.addVisual(raquetaJugador)
		game.addVisual(raquetaJugador2)
		red.aparecerRed()
		
		contadorDePuntos.inicializarPuntos()
		
// MAIN DE TECLAS Y COLISIONE
                                                         
		config.configurarTeclas()
		golpeNulo.golpearPelota()
	
		

		reproductorDeSonidos.musicaAmbiente().play()
		
		
		                                             
		game.onTick(400,"GravedadPelota", {pelota.gravedad()})
		game.onTick(50,"GravedadJugador1", {jugador1.gravedad()})
        game.onTick(50,"GravedadJugador2", {jugador2.gravedad()})
        
		game.onTick(50,"Habilitar salto para jugador1",{jugador1.habilitarSalto()})
		game.onTick(50,"Habilitar salto para jugador2",{jugador2.habilitarSalto()})
		
		game.onTick(1,"Evaluar golpeEnRed",{pelota.tocarRed()})
		game.onTick(1,"Evaluar doblePique",{pelota.doblePique()})
        game.onTick(1000,"Evaluar Limites pelota",{pelota.limitarPosicion()})
        
      //  game.onTick(500,"limitarPosicion",{jugador1.limitarPosicion()})
     //   game.onTick(500,"Limitar posicion de jugadores derecho",{jugador2.limitarPosicionDerecha()})
        
        
        
        
        
     //   game.onTick(1000,"Consultar si pica la pelota",{pelota.tocarPiso()})
     //		game.onTick(10,"Limites de jugador1",{jugador.direccionHaciaDondeGolpea().limitarPosicion(jugador)})
//		game.onTick(10,"Limites de jugador2",{jugador2.direccionHaciaDondeGolpea().limitarPosicion(jugador2)})
     
	}
	
}
//game.cleanUp()

/* 
object evaluarPiques{
	if(pelota.piques()==2){
		pelota.jugadorQueGolpea().sumarPunto()
        pelota.reiniciarPosicion()
        game.removeTickEvent(pelota.tipoDeGolpe().nombre())
	}
}
*/
                         // CONFIGURACION DE TECLAS Y COLISIONES

object config{
	


    method configurarTeclas(){
    	
        //CONFIGURACION DE TECLAS DE JUGADOR 1
        keyboard.a().onPressDo({moverJugador.moverJugadorHacia(izquierda,jugador1)})
        keyboard.d().onPressDo({moverJugador.moverJugadorHacia(derecha,jugador1)})
        keyboard.s().onPressDo({game.removeTickEvent(jugador1.onTickName())
        	jugador1.estaEnMovimiento(false)
        })
        keyboard.w().onPressDo({jugador1.saltar()  
        	jugador1.deshabilitarSalto()
        })
        
        keyboard.c().onPressDo({pelota.golpe(jugador1,jugador2,golpeBasico)})
        keyboard.v().onPressDo({pelota.golpe(jugador1,jugador2,golpeAlto)})
        keyboard.b().onPressDo({pelota.golpe(jugador1,jugador2,golpeRemate)})
   
        // CONFIGURACION DE TECLAS JUGADOR 2      
   
        keyboard.left().onPressDo({moverJugador.moverJugadorHacia(izquierda,jugador2)})
        keyboard.right().onPressDo({moverJugador.moverJugadorHacia(derecha,jugador2)})
        keyboard.down().onPressDo({game.removeTickEvent(jugador2.onTickName())
        	jugador2.estaEnMovimiento(false)
        })
        	
        keyboard.up().onPressDo({jugador2.saltar()
        	jugador2.deshabilitarSalto()})
      
        //keyboard.space().onPressDo({pelota.golpe(jugador2,golpeAlto) pelota.tipoDeGolpe(golpeAlto)}) reservo el space() para el jugador estrella  
        keyboard.j().onPressDo({pelota.golpe(jugador2,jugador1,golpeBasico)})
        keyboard.k().onPressDo({pelota.golpe(jugador2,jugador1,golpeAlto)})
        keyboard.l().onPressDo({pelota.golpe(jugador2,jugador1,golpeRemate)})     
        					
       
        }
        
}

	

	
	
                  











