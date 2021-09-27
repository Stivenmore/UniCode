import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:unicode/domain/Models/Normals/modelCourses.dart';
import 'package:unicode/domain/Services/AbstraHome.dart';
import 'package:unicode/screens/utils/widgetroute.dart';

class HomeRepository with ChangeNotifier implements AbstractHome {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CoursesModel coursesModel = CoursesModel();
  HomeRepository() {
    this.getCourses();
  }
  @override
  getCourses() async {
    try {
      final usercloud = await _firestore
          .collection('Users')
          .doc(_firebaseAuth.currentUser!.uid)
          .collection('Mis cursos')
          .doc('Programacion')
          .get();
      print('_______');
      print(usercloud.data());
      print('_______');
      var list = usercloud.data();
      if (coursesModel.capmodel == null || coursesModel.capmodel!.length == 0) {
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
            cap.docs.map((doc){
              return doc.data();
            }).toList(),
          );
        });
        /*List<CapituloModel> capmodel = (cap as Iterable)
            .map((e) => CapituloModel.fromFirebase(e))
            .toList();
          coursesModel.capmodel = capmodel;*/
      }
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
}
