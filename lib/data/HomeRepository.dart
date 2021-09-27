import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:unicode/domain/Models/Hive/UserHive.dart';
import 'package:unicode/domain/Models/Normals/modelCourses.dart';
import 'package:unicode/domain/Models/Normals/modelallCourses.dart';
import 'package:unicode/domain/Services/AbstraHome.dart';
import 'package:unicode/screens/utils/widgetroute.dart';

class HomeRepository with ChangeNotifier implements AbstractHome {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CoursesModel coursesModel = CoursesModel();
  List<AllCoursesModel> allcoursesModel = [];
  HomeRepository() {
    this.getCourses();
    this.getallcourses();
  }
  @override
  getCourses() async {
    try {
      _firestore.runTransaction((transaction) async {
        final capReference = _firestore
            .collection('Users')
            .doc(_firebaseAuth.currentUser!.uid)
            .collection('Mis cursos')
            .doc('Programacion');
        final capitulos = await transaction.get(capReference);
        final cap = await _firestore
            .collection('Users')
            .doc(_firebaseAuth.currentUser!.uid)
            .collection('Mis cursos')
            .doc('Programacion')
            .collection('Capitulos')
            .get();
        coursesModel = CoursesModel.fromFirebase(
          capitulos.data() as Map<String, dynamic>,
          cap.docs.map((doc) {
            return doc.data();
          }).toList(),
        );
      });
      print('_______');
      print(coursesModel.capmodel![0]);
      print('_______');
      notifyListeners();
    } catch (e) {
      print('____________');
      print(e);
      print('____________');
    }
  }

  @override
  setMeCourses(
      {required String description,
      required String imagepromotion,
      required String nivel,
      required String nombre,
      required String url,
      required String namecurse}) async {
        final box = Hive.box<UserHive>('user');
        final user = box.get(0) as UserHive;
     await _firestore
        .collection('Users')
        .doc(_firebaseAuth.currentUser!.uid)
        .collection('Mis cursos')
        .doc(namecurse).set({
          'descripcion': description,
          'imagepromotion': imagepromotion,
          'nivel': nivel,
          'tutor': user.username,
          'namecurse': namecurse
        });
     await _firestore
        .collection('Users')
        .doc(_firebaseAuth.currentUser!.uid)
        .collection('Mis cursos')
        .doc(namecurse).collection('Capitulos').doc().set({
          'nombre': nombre,
          'url': url
        });
  }

  @override
  getallcourses() async{
    try {
      final capReference = await _firestore
            .collection('Users')
            .doc(_firebaseAuth.currentUser!.uid)
            .collection('Mis cursos').get();
        allcoursesModel = (capReference.docs).map((e) => AllCoursesModel.fromFirebase(e)).toList();  
      print('_______');
      print(allcoursesModel.length);
      print('_______');
      notifyListeners();
    } catch (e) {
      print('____________');
      print(e);
      print('____________');
    }
  }
}
