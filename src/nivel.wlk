import juego.*
import estaticos.*
import wollok.game.*



object partido{
	
		method iniciar() {
		game.addVisualCharacter(jugador2)
		game.addVisual(jugador)
		game.addVisual(pelota)		
		game.addVisual(red)
		game.addVisual(raqueta)
		//game.addVisual(cabezaRoger)
		config.configurarTeclas()
		config.configurarColisiones()
		game.onTick(500,"GravedadPelota", {pelota.gravedad()})
		game.onTick(100,"GravedadJugador1", {jugador.gravedad()})
        game.onTick(100,"GravedadJugador2", {jugador2.gravedad()})
		
	}
	
}



object config{
/* 
	method configurarTeclasRafa(){
        keyboard.w().onPressDo({rafa.saltar()})
        keyboard.d().onPressDo({rafa.irA(rafa.position().right(1))})
        keyboard.a().onPressDo({rafa.irA(rafa.position().left(1))})
}*/

method configurarTeclas(){

        keyboard.a().onPressDo({jugador.irA(jugador.position().left(1), izquierda)})
        keyboard.d().onPressDo({jugador.irA(jugador.position().right(1), derecha)})
        keyboard.w().onPressDo({jugador.saltar()})
        
        }

	method configurarColisiones(){
	        game.onCollideDo(jugador,{unaPelota =>
	            unaPelota.golpe(jugador)})
            game.onCollideDo(jugador2,{unaPelota =>
	            unaPelota.golpe(jugador2)})
}


}











