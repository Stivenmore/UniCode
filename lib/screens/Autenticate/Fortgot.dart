import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:unicode/data/UserRepository.dart';
import 'package:unicode/screens/utils/StreamValidator.dart';
import 'package:unicode/screens/utils/responsive.dart';
import 'package:unicode/screens/utils/theme.dart';

class FortGot extends StatefulWidget {
  FortGot({Key? key}) : super(key: key);

  @override
  _FortGotState createState() => _FortGotState();
}

class _FortGotState extends State<FortGot> {
  final _formKey = GlobalKey<FormState>();
  final RoundedLoadingButtonController controller =
      RoundedLoadingButtonController();
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  IconData lock = CupertinoIcons.eye_slash;
  final registerBloc = RegisterBloc();
  bool obstru = true;

  UserRepository _repository = UserRepository();

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: SingleChildScrollView(
        child: Container(
          height: responsive.height,
          width: responsive.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: responsive.hp(20),
                  ),
                  Image.asset('assets/autenticate/login.png'),
                  SizedBox(
                    height: responsive.hp(2),
                  ),
                  Text(
                    'Restablecer contraseña',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w700)),
                  ),
                  SizedBox(
                    height: responsive.hp(1),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Recibiras un correo electronico para restablecer tu contraseña.',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(color: UniCode.gray2)),
                    ),
                  ),
                  SizedBox(
                    height: responsive.hp(4),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: email,
                    scrollPadding: EdgeInsets.all(0.0),
                    style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w800)),
                    cursorColor: Theme.of(context).primaryColor,
                    decoration: InputDecoration(
                      labelText: 'Correo',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: UniCode.gray2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: UniCode.gray2),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: UniCode.gray2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: UniCode.gray2),
                      ),
                      focusColor: UniCode.gray2,
                      fillColor: UniCode.gray2,
                    ),
                    validator: (String? value) =>
                        value!.isEmpty ? 'Ingresa tu correo' : null,
                  ),
                  SizedBox(
                    height: responsive.hp(2),
                  ),
                  Container(
                    width: responsive.wp(70),
                    child: RoundedLoadingButton(
                      color: Theme.of(context).primaryColor,
                      controller: controller,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final bool resp =
                              await _repository.forget(email: email.text);
                          print('ForGet: ' + resp.toString());
                          if (resp) {
                            Timer(Duration(seconds: 2), () {
                              controller.success();
                            });
                            Timer(Duration(seconds: 4), () {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, '/login', (route) => false);
                            });
                          } else {
                            Timer(Duration(seconds: 2), () {
                              controller.error();
                            });
                          }
                        } else {
                          Timer(Duration(seconds: 2), () {
                            controller.error();
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text('Error')));
                          });
                          Timer(Duration(seconds: 3), () {
                            controller.reset();
                          });
                        }
                      },
                      child: Text(
                        'Enviar Correo',
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: responsive.hp(3),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
