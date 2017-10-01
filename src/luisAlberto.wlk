import Musico.*
import guitarras.*

object luisAlberto inherits Musico{
	var guitarraActual = fender

	method guitarraActual(unaGuitarra) {
		guitarraActual = unaGuitarra
	}

	method valorGuitarra() {
		return guitarraActual.valor()
	}

	method habilidad() {
		return 100.min(8 * self.valorGuitarra())
	}

	method interpretaBienCancion(unaCancion) {
		return true
	}

	method costoPresentacion(unaPresentacion) {
		if(unaPresentacion.antesDe(new Date(01,09,2017))){
			return 1000
		}else{
			return 1200
		}
	}
}