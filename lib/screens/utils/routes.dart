import 'package:unicode/screens/utils/widgetroute.dart';

final Map <String, WidgetBuilder> routes = {
  '/':  (BuildContext context) => Splash(),
  '/home': (BuildContext context) => Home(),
  '/login': (BuildContext context) => Login(),
  '/onboarding': (BuildContext context) => Onboarding(),
  '/register': (BuildContext context) => Register(),
  '/fortgot': (BuildContext context) => FortGot(),
  '/allhome': (BuildContext context) => AllHome(),
  '/search': (BuildContext context) => Search(),
  '/favorite': (BuildContext context) => Favorite(),
  '/profile' : (BuildContext context) => Profile()
};