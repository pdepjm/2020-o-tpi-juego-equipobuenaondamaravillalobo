import juego.*
import estaticos.*
import wollok.game.*


// DECLARACION DE JUGADORES DISPONIBLES CON SUS RESPECTIVAS RAQUETAS


object partido{
	
		method iniciar(){
			
// OBJETOS MOSTRADOS POR PANTALLA
                                                 
		game.addVisual(jugador)
		game.addVisual(jugador2)
		game.addVisual(pelota)
		game.addVisual(cabezaRoger)
		game.addVisual(raquetaJugador)
		game.addVisual(raquetaJugador2)
		game.addVisual(red1)
		game.addVisual(red2)
		game.addVisual(red3)
		game.addVisual(red4)
		game.addVisual(red5)
		game.addVisual(red6)
		//game.addVisual(red7)
		//game.addVisual(red8)
		//game.addVisual(red9)
		
		
// MAIN DE TECLAS Y COLISIONE
                                                         
		config.configurarTeclas()
		//config.configurarColisiones()
		
//REPETICION DE EVENTOS 
		                                             
		game.onTick(400,"GravedadPelota", {pelota.gravedad()})
		game.onTick(50,"GravedadJugador1", {jugador.gravedad()})
        game.onTick(50,"GravedadJugador2", {jugador2.gravedad()})
		game.onTick(50,"Habilitar salto para jugador1",{jugador.habilitarSalto()})
		game.onTick(50,"Habilitar salto para jugador2",{jugador2.habilitarSalto()})
		game.onTick(1,"evaluarGolpeEnRed",{pelota.tocarRed()})
   	    game.onTick(10,"Puntaje",{puntajeJugador1.mostrarPuntos()})
		
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
        keyboard.a().onPressDo({moverJugador.moverJugadorHacia(izquierda,jugador)})
        keyboard.d().onPressDo({moverJugador.moverJugadorHacia(derecha,jugador)})
        keyboard.s().onPressDo({game.removeTickEvent(jugador.onTickDeMovimiento())
        	jugador.estaEnMovimiento(false)
        })
        keyboard.w().onPressDo({jugador.saltar()  
        	jugador.deshabilitarSalto()
        })
        
        keyboard.c().onPressDo({pelota.golpe(jugador,golpeBasico)})
        keyboard.v().onPressDo({pelota.golpe(jugador,golpeAlto)})
        keyboard.b().onPressDo({pelota.golpe(jugador,golpeRemate)})
   
// CONFIGURACION DE TECLAS JUGADOR 2      
   
        keyboard.left().onPressDo({moverJugador.moverJugadorHacia(izquierda,jugador2)})
        keyboard.right().onPressDo({moverJugador.moverJugadorHacia(derecha,jugador2)})
        keyboard.down().onPressDo({game.removeTickEvent(jugador2.onTickDeMovimiento())
        	jugador2.estaEnMovimiento(false)})
        	
        keyboard.up().onPressDo({jugador2.saltar()
        	jugador2.deshabilitarSalto()})
      
        //keyboard.space().onPressDo({pelota.golpe(jugador2,golpeAlto) pelota.tipoDeGolpe(golpeAlto)})  
        keyboard.j().onPressDo({pelota.golpe(jugador2,golpeBasico)})
        keyboard.k().onPressDo({pelota.golpe(jugador2,golpeAlto)})
        keyboard.l().onPressDo({pelota.golpe(jugador2,golpeRemate)})     
        
        
        
        
   
        //puntaje2.mostrarPuntos()
        }
        
}

	

	
	
                  











