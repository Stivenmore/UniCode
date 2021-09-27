import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unicode/data/HomeRepository.dart';
import 'package:unicode/screens/utils/responsive.dart';

class AddCourses extends StatefulWidget {
  AddCourses({Key? key}) : super(key: key);

  @override
  _AddCoursesState createState() => _AddCoursesState();
}

class _AddCoursesState extends State<AddCourses> {
  List buu = [];

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive(context);
    final provider = Provider.of<HomeRepository>(context).coursesModel;
    return Scaffold(
        body: Container(
      height: responsive.height,
      width: responsive.width,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              height: 200,
              child: CustomScrollView(
                scrollDirection: Axis.horizontal,
                slivers: [
                  SliverGrid(
                    delegate: SliverChildBuilderDelegate((_, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          color: Colors.blue,
                          height: 200,
                          width: 200,
                          child: Text(provider.capmodel![0].nombre!, style: TextStyle(color: Colors.white, fontSize: 22)),
                        ),
                      );
                    }, childCount: 12),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1),
                  )
                ],
              ),
            ),
          ),
          SliverGrid(
            delegate: SliverChildBuilderDelegate((_, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.red,
                  height: 100,
                  width: 100,
                  child: Text(provider.descripcion == null? '' : provider.descripcion!),
                ),
              );
            }, childCount: 4),
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
          )
        ],
      ),
    ));
  }
}
