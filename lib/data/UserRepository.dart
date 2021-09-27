import 'package:hive/hive.dart';
import 'package:unicode/domain/Models/Hive/UserHive.dart';
import 'package:unicode/domain/Services/AbstraAutenticate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository implements AbstractServices {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  String get userUid => _firebaseAuth.currentUser!.uid;
  
   bool get isAuth =>
      _firebaseAuth.currentUser != null &&
      _firebaseAuth.currentUser?.uid != null;

  @override
  Future login({required String email, required String password}) async {
    try {
      final user = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      print('user.id auth: ' + user.user!.uid);
      if (user.user!.uid != '') {
        final usercloud =
            await _firestore.collection('Users').doc(user.user!.uid).get();
        final box = Hive.box<UserHive>('user');
        box.delete(0);
        UserHive userHive = UserHive(
            username: usercloud.data()!['fullName'],
            email: usercloud.data()!['email'],
            password: usercloud.data()!['password']);
        box.add(userHive);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future register(
      {required String email,
      required String password,
      required String fullname}) async {
    final box = Hive.box<UserHive>('user');
    try {
      final credentials = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (credentials.user!.uid != '') {
        await _firestore
            .collection('Users')
            .doc(credentials.user!.uid)
            .set({'email': email, 'fullName': fullname, 'password': password});
        box.delete(0);
        UserHive userHive =
            UserHive(username: fullname, email: email, password: password);
        box.add(userHive);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future forget({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future signOut() async {
    try {
      await _firebaseAuth.signOut();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
