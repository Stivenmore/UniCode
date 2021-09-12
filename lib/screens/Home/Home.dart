import 'package:flutter/material.dart';
import 'package:unicode/data/UserRepository.dart';
import 'package:unicode/screens/utils/responsive.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  UserRepository _repository = UserRepository();

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Scaffold(
      body: Container(
        height: responsive.height,
        width: responsive.width,
        child: Center(
          child: TextButton(onPressed: () async{
            await _repository.signOut();
            Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
          }, child: Text('Exit')),
        ),
      ),
    );
  }
}
