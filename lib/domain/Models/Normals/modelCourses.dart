

import 'package:unicode/domain/Models/Normals/modelcapitulo.dart';

class CoursesModel {
  final String? tutor;
  final String? nivel;
  final String? descripcion;
  final String? imagepromotion;
  late final List<CapituloModel>? capmodel;

  CoursesModel({this.imagepromotion, this.tutor, this.nivel, this.descripcion, this.capmodel});

   factory CoursesModel.fromFirebase(Map<String, dynamic> capDetails, List? caps) { 
    final allcap = List.from(caps ?? []);

   return CoursesModel(
     imagepromotion: capDetails['imagepromotion'] as String? ?? '',
     tutor: capDetails['tutor'] as String? ?? '',
     nivel: capDetails['nivel'] as String? ?? '',
     descripcion: capDetails['descripcion'] as String? ?? '',
     capmodel: allcap.map((e){
       return CapituloModel.fromFirebase(e);
     }).toList());
     }
}