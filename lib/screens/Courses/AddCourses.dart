import 'package:flutter/material.dart';

class AddCourses extends StatefulWidget {
  AddCourses({Key? key}) : super(key: key);

  @override
  _AddCoursesState createState() => _AddCoursesState();
}

class _AddCoursesState extends State<AddCourses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('AddCourses'),
      ),
    );
  }
}