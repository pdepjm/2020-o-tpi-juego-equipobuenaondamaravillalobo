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
		game.addVisual(red7)
		game.addVisual(red8)
		game.addVisual(red9)
		
		
// MAIN DE TECLAS Y COLISIONES
                                                         
		config.configurarTeclas()
		//config.configurarColisiones()
		
//REPETICION DE EVENTOS 
		                                             
		game.onTick(500,"GravedadPelota", {pelota.gravedad()})
		game.onTick(50,"GravedadJugador1", {jugador.gravedad()})
        game.onTick(50,"GravedadJugador2", {jugador2.gravedad()})
		game.onTick(50,"Habilitar salto para jugador1",{jugador.habilitarSalto()})
		game.onTick(50,"Habilitar salto para jugador2",{jugador2.habilitarSalto()})
		game.onTick(1,"evaluarGolpeEnRed",{pelota.tocarRed()})
		
		
	}
	
}
//game.cleanUp()



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
        }
        
        
        
        
//Cuando la pelota toca la red(vuelve a iniciar el punto y se suma el contador uno dependiendo si
/* 
    method configurarColisiones(){
		game.onCollideDo(red1,{unapelota=>unapelota.reiniciarPosicion()})
		game.onCollideDo(red2,{unapelota=>unapelota.reiniciarPosicion()})
		game.onCollideDo(red3,{unapelota=>unapelota.reiniciarPosicion()})
		game.onCollideDo(red4,{unapelota=>unapelota.reiniciarPosicion()})
		game.onCollideDo(red5,{unapelota=>unapelota.reiniciarPosicion()})
		game.onCollideDo(red6,{unapelota=>unapelota.reiniciarPosicion()})
		game.onCollideDo(red7,{unapelota=>unapelota.reiniciarPosicion()})
        game.onCollideDo(red8,{unapelota=>unapelota.reiniciarPosicion()})
		game.onCollideDo(red9,{unapelota=>unapelota.reiniciarPosicion()})
		game.onCollideDo(red10,{unapelota=>unapelota.reiniciarPosicion()})
		game.onCollideDo(red11,{unapelota=>unapelota.reiniciarPosicion()})
		game.onCollideDo(red12,{unapelota=>unapelota.reiniciarPosicion()})
		game.onCollideDo(red13,{unapelota=>unapelota.reiniciarPosicion()})
		game.onCollideDo(red14,{unapelota=>unapelota.reiniciarPosicion()})
	}
*/	
	
}
	
	
                  // POLIMORFISMO: EL MENSAJE GOLPE VARÍA CON DISTINTAS TRAYECTORIAS Y VELOCIDADES

                                        // CUANDO SE GOLPEA AL APRETAR, PELOTA REALIZA EL GOLPE.
                                        // CUANDO COLISIONA CON LA RAQUETA, LA RAQUETA REALIZA EL GOLPE.
                                        // CUANDO COLISIONA CON EL JUGADOR, EL JUGADOR HACE EL GOLPE.













