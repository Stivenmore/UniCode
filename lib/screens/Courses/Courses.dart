import 'package:flutter/material.dart';
import 'package:unicode/screens/Courses/AddCap.dart';
import 'package:unicode/screens/Courses/AddCourses.dart';

class Courses extends StatefulWidget {
  Courses({Key? key}) : super(key: key);

  @override
  _CoursesState createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 2, child: Scaffold(
      appBar: AppBar(
        bottom: TabBar(tabs: [
          Tab(text: 'Agrega Cursos',),
          Tab(text: 'Agrega Capitulo',)
        ]),
        title: Text('Courses'),
        centerTitle: true,
        
      ),
      body: TabBarView(
            children: [
              AddCourses(),
              AddCap()
            ],
          ),
    ));
  }
}
