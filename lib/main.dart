import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unicode/domain/Models/Hive/UserHive.dart';
import 'package:unicode/screens/locals/prefs.dart';
import 'package:unicode/screens/utils/routes.dart';
import 'package:unicode/screens/utils/theme.dart';
import 'package:path_provider/path_provider.dart' as path;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  final prefs = new UserPreferences();
  await prefs.initPrefs();
  await Firebase.initializeApp();
  final appDocumentDir = await path.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(UserHiveAdapter());
  await Hive.openBox<UserHive>('user');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UniCode',
      routes: routes,
      theme: UniCode.defaultTheme,
      initialRoute: '/',
    );
  }
}
