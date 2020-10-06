import juego.*
import estaticos.*
import wollok.game.*



object partido{
	
		method iniciar() {
		game.addVisualCharacter(roger)
		game.addVisual(pelota)		
		game.addVisual(red)
		game.addVisual(raqueta)
		config.configurarTeclas()
		config.configurarColisiones()
		game.onTick(500,"GravedadPelota", {pelota.caer(0.5)})
		game.onTick(100,"GravedadRoger", {roger.caer(0.5)})
		
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

        keyboard.left().onPressDo({roger.irA(roger.position().left(1))})
        keyboard.right().onPressDo({ roger.irA(roger.position().right(1))})
        keyboard.up().onPressDo({roger.saltar()})
}

	method configurarColisiones(){
	        game.onCollideDo(roger,{unaPelota =>
	            unaPelota.golpe()
})

}}










