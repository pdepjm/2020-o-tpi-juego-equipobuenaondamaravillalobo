import wollok.game.*

object pepita {

    method position() {
        return game.center()
    }

    method image() {
        return "pepita.png"
    }

}


object roger{
    var property position = game.at(3,1)

    method image() = "roger.png"
}

object raquetaRoger{
    var property position = 
    method image() = "raqueta1.png"
}


object pelota{
    var property position = 0
    method image() = "pelota.png"

}

object red{
    var position = game.at(6,0)

    method image() = "red.png"
    method position() = position 
}

/* 
 * 
 * 
 object rafa{
    var property position = game.at(9,1)
    method image() = "rafa.png"
}
* 
* 
object raquetaRafa{
    var property position = game.at(rafa.position().x()) + 1 ,rafa.position().y()
    method image() = "raqueta2.png"

}

*/

