import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:unicode/screens/components/map.dart';
import 'package:unicode/screens/locals/prefs.dart';
import 'package:unicode/screens/utils/responsive.dart';
import 'package:unicode/screens/utils/theme.dart';

class Onboarding extends StatefulWidget {
  Onboarding({Key? key}) : super(key: key);

  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final _prefs = UserPreferences();
  final RoundedLoadingButtonController controller =
      RoundedLoadingButtonController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: Container(
        height: responsive.hp(100),
        width: responsive.wp(100),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: responsive.hp(90),
                width: responsive.wp(100),
                child: PageView.builder(
                    physics: BouncingScrollPhysics(),
                    onPageChanged: (value) {
                      setState(() {
                        currentPage = value;
                      });
                    },
                    itemCount: onboarding.length,
                    itemBuilder: (_, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: responsive.height * .1,
                            ),
                            Container(
                                height: responsive.height * .5,
                                child: Lottie.asset(
                                  onboarding[index]['imagen'],
                                )),
                            Text(
                              onboarding[index]['sentence'],
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 28,
                                      color: Theme.of(context).primaryColor)),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: responsive.height * .02,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                onboarding[index]['text'],
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontSize: 18, color: UniCode.gray2)),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              height: responsive.height * .02,
                            ),
                            Container(
                              child: onboarding[index]['getstartted'] == true
                                  ? Container(
                                      width: responsive.wp(50),
                                      child: RoundedLoadingButton(
                                        color: Theme.of(context).primaryColor,
                                        controller: controller,
                                        onPressed: () {
                                          _prefs.primary = false;
                                          Timer(Duration(seconds: 2), (){
                                            controller.success();
                                          });
                                          Timer(Duration(seconds: 3), (){
                                            Navigator.pushNamed(context, '/login');
                                          });
                                          Timer(Duration(seconds: 4), (){
                                            controller.reset();
                                          });
                                        },
                                        child: Text(
                                          'COMENZAR',
                                          style: GoogleFonts.poppins(
                                              textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                        ),
                                      ),
                                    )
                                  : Text(''),
                            )
                          ],
                        ),
                      );
                    }),
              ),
              Container(
                height: 30,
                width: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    onboarding.length,
                    (index) => buildDot(index: index),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AnimatedContainer buildDot({required int index}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.only(right: 5),
      height: currentPage == index ? 22 : 10,
      width: currentPage == index ? 7 : 4,
      decoration: BoxDecoration(
        color: currentPage == index
            ? Theme.of(context).primaryColor
            : Theme.of(context).shadowColor,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
