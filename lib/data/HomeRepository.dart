import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hive/hive.dart';
import 'package:unicode/domain/Models/Hive/UserHive.dart';
import 'package:unicode/domain/Models/Normals/modelCourses.dart';
import 'package:unicode/domain/Models/Normals/modelallCourses.dart';
import 'package:unicode/domain/Services/AbstraHome.dart';
import 'package:unicode/screens/utils/widgetroute.dart';

class HomeRepository with ChangeNotifier implements AbstractHome {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseStorage _storage = FirebaseStorage.instance;
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
      required File imagepromotion,
      required String nivel,
      required String nombre,
      required String url,
      required String namecurse}) async {
    try {
      final box = Hive.box<UserHive>('user');
      final user = box.get(0) as UserHive;
      final postimageRef = _storage.ref().child('ImagenCap');
      var timekey = DateTime.now();

      final UploadTask uploadTask = postimageRef
          .child(timekey.toString() + '.jpg')
          .putFile(imagepromotion);
      var urlImage = await (await uploadTask).ref.getDownloadURL();
      var urlpromotion = urlImage;
      int id = new DateTime.now().millisecondsSinceEpoch;
      final index = id;
      await _firestore
          .collection('Users')
          .doc(_firebaseAuth.currentUser!.uid)
          .collection('Mis cursos')
          .doc(namecurse)
          .set({
        'descripcion': description,
        'imagepromotion': urlpromotion,
        'nivel': nivel,
        'tutor': user.username,
        'namecurse': namecurse
      });
      await _firestore
          .collection('Users')
          .doc(_firebaseAuth.currentUser!.uid)
          .collection('Mis cursos')
          .doc(namecurse)
          .collection('Capitulos')
          .doc()
          .set({'nombre': nombre, 'url': url});

      await _firestore
          .collection('Cursos')
          .doc('${index.toString()}$nivel')
          .set({
        'descripcion': description,
        'imagepromotion': urlpromotion,
        'nivel': nivel,
        'tutor': user.username,
        'namecurse': namecurse
      });

      await _firestore
          .collection('Cursos')
          .doc('${index.toString()}$nivel')
          .collection('Capitulos')
          .doc()
          .set({'nombre': nombre, 'url': url});
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  getallcourses() async {
    try {
      final capReference = await _firestore
          .collection('Users')
          .doc(_firebaseAuth.currentUser!.uid)
          .collection('Mis cursos')
          .get();
      allcoursesModel = (capReference.docs)
          .map((e) => AllCoursesModel.fromFirebase(e))
          .toList();
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

  @override
  setnewCap(
      {required String description,
      required String nivel,
      required String imagepromotion,
      required String namecurse,
      required String nombre,
      required String url}) async {
    final box = Hive.box<UserHive>('user');
    final user = box.get(0) as UserHive;
    try {
      await _firestore
          .collection('Users')
          .doc(_firebaseAuth.currentUser!.uid)
          .collection('Mis cursos')
          .doc(namecurse)
          .collection('Capitulos')
          .doc()
          .set({'nombre': nombre, 'url': url});
      final resp = await _firestore
          .collection('Cursos')
          .where('descripcion', isEqualTo: description)
          .where(
            'imagepromotion',
            isEqualTo: imagepromotion,
          )
          .where('namecurse', isEqualTo: namecurse)
          .where('nivel', isEqualTo: nivel)
          .get();
      await _firestore
          .collection('Cursos')
          .doc(resp.docs[0].id)
          .collection('Capitulos')
          .doc()
          .set({'nombre': nombre, 'url': url});
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}

/*
'descripcion': description,
        'imagepromotion': urlpromotion,
        'nivel': nivel,
        'tutor': user.username,
        'namecurse': namecurse
*/