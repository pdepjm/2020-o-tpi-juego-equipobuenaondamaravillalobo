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

        keyboard.a().onPressDo({moverJugador.moverJugadorHacia(izquierda) })
        keyboard.d().onPressDo({moverJugador.moverJugadorHacia(derecha) })
        keyboard.s().onPressDo({game.removeTickEvent("Jugador corriendo")
        	moverJugador.jugadorEstaEnMovimiento(false)
        })
        keyboard.w().onPressDo({jugador.saltar()
        	jugador.deshabilitarSalto()
        })
        keyboard.space().onPressDo({pelota.golpe(jugador)})
 
  
        keyboard.left().onPressDo({moverJugador2.moverJugadorHacia(izquierda) })
        keyboard.right().onPressDo({moverJugador2.moverJugadorHacia(derecha) })
        keyboard.up().onPressDo({jugador2.saltar()
        	jugador2.deshabilitarSalto()
        })
		keyboard.down().onPressDo({game.removeTickEvent("Jugador2 corriendo")
        	moverJugador2.jugadorEstaEnMovimiento(false)
        })
        keyboard.m().onPressDo({pelota.golpe(jugador2)})       
        }

/* 	method configurarColisiones(){

            game.onCollideDo(jugador,{unaPelota =>
                jugador.golpe(jugador)})
            game.onCollideDo(jugador2,{unaPelota =>
                jugador2.golpe(jugador2)})


            game.onCollideDo(raquetaJugador,{unaPelota =>
                raquetaJugador.golpe(jugador)})
            game.onCollideDo(raquetaJugador2,{unaPelota =>
                raquetaJugador2.golpe(jugador2)})
   }
		
		*/
	}
                          // POLIMORFISMO: EL MENSAJE GOLPE VARÍA CON DISTINTAS TRAYECTORIAS Y VELOCIDADES

                                        // CUANDO SE GOLPEA AL APRETAR, PELOTA REALIZA EL GOLPE.
                                        // CUANDO COLISIONA CON LA RAQUETA, LA RAQUETA REALIZA EL GOLPE.
                                        // CUANDO COLISIONA CON EL JUGADOR, EL JUGADOR HACE EL GOLPE.













