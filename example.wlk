------------------------------ CLASE PERSONAS ------------------------------
class Persona {
  var property edad = 0

  const emociones = []

  method esAdolecente() = edad.between(12, 19)

  method nuevaEmocion(emocion) = emociones.add(emocion)

  method explotar() = emociones.all({_ => _.puedeLiberar()})

  method vivirEvento(evento) {
    emociones.apply({_ => _.vivirEvento(evento)})
  }

  //method eventoAGrupo(evento, grupo) = grupo.apply({_ => _.vivirEvento(evento)})
}

------------------------------ CLASE EMOCIONES ------------------------------

class Emociones {
    var property eventosVividos
    var property intensidad
    var property intensidadLimite
    var property alterada

    method puedeLiberar() = self.intensidadElevada()

    method intensidadElevada() = intensidad > intensidadLimite

    method liberar(evento) {intensidad -= evento.impacto()}

    method vivirEvento(evento) {
        if(self.puedeLiberar()){
            self.liberar(evento)
        }
    }
}

object furia inherits Emociones(eventosVividos = 0, intensidad = 100, intensidadLimite = 200, alterada=0) {

    const palabrotas = []

    method aprenderPalabra(palabra) = palabrotas.add(palabra)

    method olvidadPalabra(palabra) = palabrotas.remove(palabra)

    override method puedeLiberar() = super() && palabrotas.any({_ => _.length() > 7})

    override method liberar(evento) {
        super({palabrotas.remove(palabrotas.first())})
    }
}

object alegria inherits Emociones(eventosVividos = 0, intensidad = 0, intensidadLimite = 100, alterada=0) {

    override method puedeLiberar() = super() && eventosVividos.even()

    override method intensidad(valor){
        if(valor<0)
        {
            return valor.abs()
        }
        else {return valor}
    }

}

object tristeza inherits  Emociones(eventosVividos = 0, intensidad = 0, intensidadLimite = 100, alterada=0) {
    var property causa = "melancolia"

    override method puedeLiberar() = super() && (causa != "melancolia") 

    override method liberar(evento) {
        super({ causa = evento.desc()})
    }
}

object desagrado inherits Emociones(eventosVividos = 0, intensidad = 0, intensidadLimite = 100, alterada=0) {
    override method puedeLiberar() = super() && (eventosVividos > intensidad)
}

object temor inherits Emociones(eventosVividos = 0, intensidad = 0, intensidadLimite = 100, alterada=0) {
    override method puedeLiberar() = super() && (eventosVividos > intensidad)
}

object ansiedad inherits Emociones(eventosVividos = 0, intensidad = 200, intensidadLimite = 250, alterada=0){
        override method puedeLiberar() = super() && temor.puedeLiberar() && tristeza.puedeLiberar()
        override method liberar(evento) {
            intensidad += evento.impacto()
        }
}

/*
En esta nueva emoción "ansiedad", la herencia es útil para poder recibir los distintos atributos y métodos que tienen todas las emociones, y con
ello darle nuevos valores a los atributos que queramos que entren en juego en esta emoción y modificar a nuestro criterio los métodos que creamos
convenientes. En este caso, estamos modificando los atributos "intensidad" e "intensidadLimite" y sobreescribiendo los métodos puedeLiberar() y
liberar().
Por otro lado, el polimorfismo nos da la posibilidad de que distintas instancias de emociones puedan responder al mismo mensaje, el cual
puede tener en cada una de estas instancias el mismo efecto o uno distinto. En este caso, estamos usando el polimorfismo en los métodos puedeLiberar(),
liberar() y llamamos a los objetos "temor" y "tristeza" para también mandarle el mensaje de puedeLiberar()
*/

------------------------------ CLASE EVENTOS ------------------------------

class Eventos {
    var property impacto
    const property desc = ""
}
