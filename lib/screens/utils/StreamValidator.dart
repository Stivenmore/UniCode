import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:unicode/screens/utils/validation.dart';


class RegisterBloc with Validators {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _showPasswordController = BehaviorSubject<bool>();

//   // Recuperar los datos del Stream
  Stream<String> get emailStream =>
      _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validarPassword);
  Stream get showPasswordStream => _showPasswordController.stream;

  Stream<bool> get formValidStream =>
      Rx.combineLatest2(emailStream, passwordStream, (dynamic e, dynamic p) => true);

//   // Insertar valores al Stream
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(String) get changeShowPassword => _passwordController.sink.add;

//   // Obtener el último valor ingresado a los streams
// con validacion de si es nulo o no
  String? get email => _emailController.value;
  String? get password => _passwordController.value;
  bool? get showPassword => _showPasswordController.value;

//Liberacion de flujos
  dispose() {
    _emailController.close();
    _passwordController.close();
    _showPasswordController.close();
  }
}