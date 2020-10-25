import juego.*
import estaticos.*
import wollok.game.*



object partido{
	
		method iniciar() {
			
// OBJETOS MOSTRADOS POR PANTALLA
                                                 
		game.addVisual(jugador2)
		game.addVisual(jugador)
		game.addVisual(pelota)		
		game.addVisual(red)
		game.addVisual(cabezaRoger)
		game.addVisual(raquetaJugador)
		game.addVisual(raquetaJugador2)
		
// MAIN DE TECLAS Y COLISIONES
                                                         
		config.configurarTeclas()
		// config.configurarColisiones()
		
//REPETICION DE EVENTOS 
		                                             
		game.onTick(500,"GravedadPelota", {pelota.gravedad()})
		game.onTick(50,"GravedadJugador1", {jugador.gravedad()})
        game.onTick(50,"GravedadJugador2", {jugador2.gravedad()})
		game.onTick(50,"Habilitar salto para jugador1",{jugador.habilitarSalto()})
		game.onTick(50,"Habilitar salto para jugador2",{jugador2.habilitarSalto()})
		   
		
	}
	
}
//game.cleanUp()



                         // CONFIGURACION DE TECLAS Y COLISIONES

object config{

    method configurarTeclas(){

        keyboard.a().onPressDo({moverJugador.moverJugadorHacia(izquierda,jugador) })
        keyboard.d().onPressDo({moverJugador.moverJugadorHacia(derecha,jugador) })
        keyboard.s().onPressDo({game.removeTickEvent(jugador.onTickDeMovimiento())
        	jugador.estaEnMovimiento(false)
        })
        keyboard.w().onPressDo({jugador.saltar()
        	jugador.deshabilitarSalto()
        })
        keyboard.space().onPressDo({pelota.golpe(jugador)})
 
  
        keyboard.left().onPressDo({moverJugador.moverJugadorHacia(izquierda,jugador2) })
        keyboard.right().onPressDo({moverJugador.moverJugadorHacia(derecha,jugador2) })
        keyboard.up().onPressDo({jugador2.saltar()
        	jugador2.deshabilitarSalto()
        })
		keyboard.down().onPressDo({game.removeTickEvent(jugador2.onTickDeMovimiento())
        	jugador2.estaEnMovimiento(false)
        })
        keyboard.m().onPressDo({pelota.golpe(jugador2)})       
        }

	}
                          // POLIMORFISMO: EL MENSAJE GOLPE VARÍA CON DISTINTAS TRAYECTORIAS Y VELOCIDADES

                                        // CUANDO SE GOLPEA AL APRETAR, PELOTA REALIZA EL GOLPE.
                                        // CUANDO COLISIONA CON LA RAQUETA, LA RAQUETA REALIZA EL GOLPE.
                                        // CUANDO COLISIONA CON EL JUGADOR, EL JUGADOR HACE EL GOLPE.













