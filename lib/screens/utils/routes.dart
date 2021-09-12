
import 'package:flutter/material.dart';
import 'package:unicode/screens/Autenticate/Fortgot.dart';
import 'package:unicode/screens/Autenticate/Login.dart';
import 'package:unicode/screens/Autenticate/Register.dart';
import 'package:unicode/screens/Home/Home.dart';
import 'package:unicode/screens/Onboard/Onboard.dart';
import 'package:unicode/screens/Splash/Splash.dart';

final Map <String, WidgetBuilder> routes = {
  '/':  (BuildContext context) => Splash(),
  '/home': (BuildContext context) => Home(),
  '/login': (BuildContext context) => Login(),
  '/onboarding': (BuildContext context) => Onboarding(),
  '/register': (BuildContext context) => Register(),
  '/fortgot': (BuildContext context) => FortGot()
};