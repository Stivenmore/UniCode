import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:unicode/data/UserRepository.dart';
import 'package:unicode/screens/utils/StreamValidator.dart';
import 'package:unicode/screens/utils/responsive.dart';
import 'package:unicode/screens/utils/theme.dart';

class Register extends StatefulWidget {
  Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final RoundedLoadingButtonController controller =
      RoundedLoadingButtonController();
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  IconData lock = CupertinoIcons.eye_slash;
  final registerBloc = RegisterBloc();
  bool obstru = true;

  UserRepository _repository = UserRepository();

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: Container(
        height: responsive.height,
        width: responsive.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: responsive.hp(8),
                  ),
                  Image.asset('assets/autenticate/register.png'),
                  SizedBox(
                    height: responsive.hp(2),
                  ),
                  Text(
                    'Registrate ahora',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w700)),
                  ),
                  SizedBox(
                    height: responsive.hp(1),
                  ),
                  Text(
                    'Por favor ingrese los detalles y continue.',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(color: UniCode.gray2)),
                  ),
                  SizedBox(
                    height: responsive.hp(2),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      controller: name,
                      scrollPadding: EdgeInsets.all(0.0),
                      style: GoogleFonts.lato(
                          textStyle: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w800)),
                      cursorColor: Theme.of(context).primaryColor,
                      decoration: InputDecoration(
                        labelText: 'Nombre completo',
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
                          value!.isEmpty ? 'Ingresa tu nombre' : null,
                    ),
                  ),
                  SizedBox(
                    height: responsive.hp(2),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: StreamBuilder(
                        stream: registerBloc.emailStream,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          return TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            onChanged: registerBloc.changeEmail,
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
                              errorMaxLines: 2,
                              errorText: snapshot.error as String?,
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
                          );
                        }),
                  ),
                  SizedBox(
                    height: responsive.hp(2),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: StreamBuilder(
                        stream: registerBloc.passwordStream,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          return TextFormField(
                            obscureText: obstru,
                            onChanged: registerBloc.changePassword,
                            controller: password,
                            scrollPadding: EdgeInsets.all(0.0),
                            style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800)),
                            cursorColor: Theme.of(context).primaryColor,
                            decoration: InputDecoration(
                              labelText: 'Contraseña',
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      obstru = !obstru;
                                    });
                                    if (obstru == false) {
                                      setState(() {
                                        lock = CupertinoIcons.eye;
                                      });
                                    } else {
                                      setState(() {
                                        lock = CupertinoIcons.eye_slash;
                                      });
                                    }
                                  },
                                  icon: Icon(
                                    lock,
                                    color: Colors.black,
                                  )),
                              errorMaxLines: 2,
                              errorText: snapshot.error as String?,
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
                                value!.isEmpty ? 'Ingresa tu contraseña' : null,
                          );
                        }),
                  ),
                  SizedBox(
                    height: responsive.hp(3),
                  ),
                  StreamBuilder(
                      stream: registerBloc.formValidStream,
                      builder: (context, snapshot) {
                        return Container(
                          width: responsive.wp(70),
                          child: RoundedLoadingButton(
                            color: Theme.of(context).primaryColor,
                            controller: controller,
                            onPressed: () async {
                              if (snapshot.hasData &&
                                  _formKey.currentState!.validate()) {
                                final resp = await _repository.register(
                                    email: email.text,
                                    password: password.text,
                                    fullname: name.text);
                                if (resp) {
                                  controller.success();
                                  Navigator.pushNamedAndRemoveUntil(
                                      context, '/home', (route) => false);
                                } else {
                                  Timer(Duration(seconds: 2), () {
                                    controller.error();
                                  });
                                  controller.reset();
                                }
                              } else {
                                Timer(Duration(seconds: 2), () {
                                  controller.error();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Error')));
                                });
                                Timer(Duration(seconds: 3), () {
                                  controller.reset();
                                });
                              }
                            },
                            child: Text(
                              'Register',
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        );
                      }),
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
