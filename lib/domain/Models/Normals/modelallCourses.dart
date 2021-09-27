import 'package:cloud_firestore/cloud_firestore.dart';

class AllCoursesModel {
  final String? tutor;
  final String? nivel;
  final String? descripcion;
  final String? imagepromotion;
  final String? namecurse;

  AllCoursesModel({this.namecurse, this.imagepromotion, this.tutor, this.nivel, this.descripcion,});

   factory AllCoursesModel.fromFirebase(QueryDocumentSnapshot<Map<String, dynamic>> capDetails) { 

   return AllCoursesModel(
     imagepromotion: capDetails['imagepromotion'] as String? ?? '',
     tutor: capDetails['tutor'] as String? ?? '',
     nivel: capDetails['nivel'] as String? ?? '',
     descripcion: capDetails['descripcion'] as String? ?? '',
     namecurse: capDetails['namecurse'] as String? ?? ''
   );}
}