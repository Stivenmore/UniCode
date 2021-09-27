import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unicode/data/HomeRepository.dart';
import 'package:unicode/screens/utils/responsive.dart';
import 'package:unicode/screens/utils/theme.dart';

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
    final provider = Provider.of<HomeRepository>(context).allcoursesModel;
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
                      return provider.length > 0 || provider.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                height: 200,
                                width: 200,
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Container(
                                        height: 200,
                                        width: 200,
                                        child: FadeInImage(
                                          placeholder:
                                              AssetImage('assets/no-image.jpg'),
                                          image: NetworkImage(
                                              provider[index].imagepromotion!),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 5,
                                      bottom: 5,
                                      child: Container(
                                        width: 200,
                                        child: Text(
                                          provider[index].tutor!,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                          overflow: TextOverflow.fade,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Container(
                              height: 200,
                              child: CircularProgressIndicator(
                                color: UniCode.defaultTheme.primaryColor,
                              ),
                            );
                    }, childCount: provider.length),
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
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: UniCode.defaultTheme.primaryColor,
                  ),
                  height: 100,
                  width: 100,
                  child: Text(''),
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
