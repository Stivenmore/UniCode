

class CapituloModel {

  final String? nombre;
  final String? url;
  CapituloModel({this.url, this.nombre});

   factory CapituloModel.fromFirebase(Map<String, dynamic> snapshot) { 
   return CapituloModel(
     url: snapshot['url'] as String?,
     nombre: snapshot['nombre'] as String?,
   );}
}