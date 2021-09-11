
import 'package:flutter/material.dart';
import 'package:unicode/screens/Onboard/Onboard.dart';
import 'package:unicode/screens/Splash/Splash.dart';

final Map <String, WidgetBuilder> routes = {
  '/':  (BuildContext context) => Splash(),
  '/onboarding': (BuildContext context) => Onboarding()
};