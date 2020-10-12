import juego.*
import estaticos.*
import wollok.game.*



object partido{
	
		method iniciar() {
		game.addVisualCharacter(jugador)
		game.addVisual(pelota)		
		game.addVisual(red)
		game.addVisual(raqueta)
		config.configurarTeclas()
		config.configurarColisiones()
		game.onTick(500,"GravedadPelota", {pelota.gravedad()})
		game.onTick(100,"GravedadRoger", {jugador.gravedad()})
		
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

        keyboard.left().onPressDo({jugador.irA(jugador.position().left(1))})
        keyboard.right().onPressDo({ jugador.irA(jugador.position().right(1))})
        keyboard.up().onPressDo({jugador.saltar()})
}

	method configurarColisiones(){
	        game.onCollideDo(jugador,{unaPelota =>
	            unaPelota.golpe()
	     
})

}}










