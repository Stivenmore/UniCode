import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unicode/screens/locals/prefs.dart';
import 'package:unicode/screens/utils/routes.dart';
import 'package:unicode/screens/utils/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  final prefs = new UserPreferences();
  await prefs.initPrefs();
  await Firebase.initializeApp();
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
