import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:unicode/screens/utils/responsive.dart';

class Splash extends StatefulWidget {
  Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    Future.delayed(Duration(seconds: 5),(){
      Navigator.pushNamedAndRemoveUntil(context, '/onboarding', (route) => false);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return Scaffold(
      body: Container(
        height: responsive.hp(100),
        width: responsive.wp(100),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('UniCode',
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold))),
              Lottie.asset('assets/onboarding0.json'),
              CircularProgressIndicator(
                backgroundColor: Theme.of(context).primaryColor,
                color: Theme.of(context).accentColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
