import Cancion.*
import guitarras.*
import Album.*
import estadoGrupal.*
import Errores.*
import CobrarEInterpretar.*

class Musico{//es una clase abstracta
	var albumes = #{}
	var grupo = tieneGrupo
	var cobraSegun
	var interpretaSegun
	
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
	method costoPresentacion(unaPresentacion){
		return cobraSegun.costoPresentacion(unaPresentacion)
	}
	method cobraSegunCuantosTocan(unCosto){
		cobraSegun= new CuantosSePresentan(unCosto)
	}
	method cobraSegunCapacidadDelLugar(unCosto,unaCantidad){
		cobraSegun= new CapacidadDelLugar(unCosto,unaCantidad)
	}
	method cobraSegunFecha(unCosto,unaInflacion,unDia,unMes,unAnio){
		cobraSegun= new Fecha(unCosto,unaInflacion,unDia,unMes,unAnio)
	}
	
	method duracionObra(){
		return albumes.sum{unAlbum=>unAlbum.duracion()}
	}
	method laPego(){
		return albumes.all({unAlbum=>unAlbum.tuvoBuenasVentas()}) 
	}
	method esCancionSuya(cancion){
		return albumes.any{album=>album.contieneCancion(cancion)}
	}
	method interpretaBienCancion(unaCancion){
		return (self.esCancionSuya(unaCancion)
				||self.habilidad()>60 
				|| interpretaSegun.interpretaBien(unaCancion)
		)
	}
	method interpretaSegunPalabra (unaPalabra){
		interpretaSegun= new Palabras(unaPalabra)
	}
	method interpretaSegunDuracion(unaDuracion){
		interpretaSegun= new Duracion(unaDuracion)
	}
	method interpretaSegunImparidad(){
		interpretaSegun= imparidad
	}
	method habilidad()//un metodo abstracto
	
	method habilidadMayorA(unaHabilidad){
		return self.habilidad()>unaHabilidad
	}
	method tieneAlgunaCancion(){
		return albumes.any{unAlbum=>unAlbum.tieneAlgunaCancion()}
	}
}

class MusicoDeGrupo inherits Musico{
	var habilidadGrupal
	var habilidadBase
	
	constructor(unaHabilidadBase,unaHabilidadGrupal){
		habilidadBase = unaHabilidadBase
		habilidadGrupal = unaHabilidadGrupal
	}
	
	override method habilidad(){
		return grupo.habilidad(habilidadGrupal,habilidadBase)
	}
	

	/*override method interpretaBienCancion(unaCancion) {
		return (unaCancion.duraMasDe(300)|| super(unaCancion))
	}*/

	/*method costoPresentacion(unaPresentacion) {
		if(unaPresentacion.esUnSolo()){
			return 100
		}else{
			return 50
		}
	}*/
}

class VocalistaPopular inherits Musico{
	var habilidadBase
	var palabraMagica
	
	constructor(unaHabilidadBase,unaPalabra){
		habilidadBase = unaHabilidadBase
		palabraMagica = unaPalabra
	}
	
	override method habilidad(){
		return grupo.habilidad(-20,habilidadBase)
	}
	
	/*override method interpretaBienCancion(unaCancion) {
		return (unaCancion.contienePalabra(palabraMagica)|| super(unaCancion))
	}*/
	
	
/* 	method costoPresentacion(unaPresentacion) {
		if(unaPresentacion.esLugarConcurrido()){
			return 500
		}else{
			return 400
		}
	}*/
	
}
