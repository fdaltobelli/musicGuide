import Cancion.*
import guitarras.*
import Album.*

object tieneGrupo{
	method habilidad(habilidadGrupal,habilidadIndividual){
		return habilidadGrupal+habilidadIndividual
	}
}
object noTieneGrupo{
	method habilidad(habilidadGrupal,habilidadIndividual){
		return habilidadIndividual
	}
}

class Musico{
	var albumes = #{}
	var grupo = tieneGrupo
	
	method albumes() = albumes
	method agregarAlbum(unAlbum){
		albumes.add(unAlbum)
	}
	method abandonarGrupo(){
		grupo = noTieneGrupo
	}
	
	method esMinimalista(){
		return albumes.all({album=>album.esMinimalista()})
	}
	method cancionesCon(unaPalabra){
		return albumes.flatMap{unAlbum=>unAlbum.cancionesCon(unaPalabra)}
	}
	method duracionObra(){
		return albumes.sum{unAlbum=>unAlbum.duracion()}
	}
	method laPego(){
		return albumes.all({unAlbum=>unAlbum.tuvoBuenasVentas()}) 
	}
}

class MusicoDeGrupo inherits Musico{
	var habilidadGrupal
	var habilidadBase
	
	constructor(unaHabilidadBase,unaHabilidadGrupal){
		habilidadBase = unaHabilidadBase
		habilidadGrupal = unaHabilidadGrupal
	}
	
	method habilidad(){
		grupo.habilidad(habilidadGrupal,habilidadBase)
	}
	

	method interpretaBienCancion(unaCancion) {
		return unaCancion.duraMasDe(300)
	}

	method costoPresentacion(unaPresentacion) {
		if(unaPresentacion.esUnSolo()){
			return 100
		}else{
			return 50
		}
	}
}

class VocalistaPopular inherits Musico{
	var habilidadBase
	var palabraMagica
	
	constructor(unaHabilidadBase,unaPalabra){
		habilidadBase = unaHabilidadBase
		palabraMagica = unaPalabra
	}
	
	method habilidad(){
		return grupo.habilidad(-20,habilidadBase)
	}
	
	method interpretaBienCancion(unaCancion) {
		return unaCancion.contienePalabra(palabraMagica)
	}
	
	
	method costoPresentacion(unaPresentacion) {
		if(unaPresentacion.esLugarConcurrido()){
			return 500
		}else{
			return 400
		}
	}
	
}

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