import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:unicode/data/UserRepository.dart';
import 'package:unicode/domain/Models/Hive/UserHive.dart';
import 'package:unicode/screens/utils/FadeAnimation.dart';
import 'package:unicode/screens/utils/responsive.dart';
import 'package:unicode/screens/utils/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final box = Hive.box<UserHive>('user');

  final customspacer = Text(
    '____________________________',
    style: TextStyle(color: UniCode.gray3.withOpacity(0.5)),
  );
  @override
  Widget build(BuildContext context) {
    final user = box.get(0) as UserHive;
    Responsive responsive = Responsive(context);
    return Scaffold(
      backgroundColor: UniCode.gray1,
      appBar: AppBar(
        backgroundColor: UniCode.gray1,
        elevation: 0.0,
        title: Text('Mi perfil',
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: UniCode.defaultTheme.primaryColor,
                    fontSize: 18))),
        centerTitle: true,
      ),
      body: Container(
        height: responsive.height,
        width: responsive.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: responsive.height * 0.05,
              ),
              FadeAnimation(300, Container(
                  height: 210,
                  width: 160,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: UniCode.defaultTheme.accentColor,
                      border:
                          Border.all(color: UniCode.defaultTheme.accentColor)),
                ),
              ),
              const SizedBox(height: 50),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: FadeAnimation(
                  1000, Container(
                    height: 160,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      color: UniCode.defaultTheme.accentColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            child: Text(
                              '${user.username!} ',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            child: Text(
                              '${user.email!}',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: UniCode.gray3.withOpacity(0.9)),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          customspacer,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  box.delete(0);
                  UserRepository().signOut();
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/login', (route) => false);
                },
                child: FadeAnimation(
                  1500, Bottom(
                    primary: Icons.close,
                    secundary: Icons.arrow_forward_ios_outlined,
                    title: 'Cerrar sesion',
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () async {
                  String url =
                      "https://wa.me/+573008167437?text=Necesito ayuda, ¿Crees que podrias dame una mano?";
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                child: FadeAnimation(
                  1500, Bottom(
                    primary: Icons.help,
                    secundary: Icons.arrow_forward_ios_outlined,
                    title: 'Ayuda',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Bottom extends StatelessWidget {
  final String title;
  final IconData primary;
  final IconData secundary;
  const Bottom({
    Key? key,
    required this.title,
    required this.primary,
    required this.secundary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Container(
        height: 60,
        width: responsive.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: UniCode.defaultTheme.accentColor,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(primary),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                        color: UniCode.defaultTheme.primaryColor,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: Icon(
                    secundary,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
