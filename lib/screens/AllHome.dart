import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:unicode/domain/Models/Hive/UserHive.dart';
import 'package:unicode/screens/Courses/Courses.dart';
import 'package:unicode/screens/Favorite/Favorite.dart';
import 'package:unicode/screens/Home/Home.dart';
import 'package:unicode/screens/Profile/Profile.dart';
import 'package:unicode/screens/utils/BottomNavMap.dart';
import 'package:unicode/screens/utils/responsive.dart';
import 'package:unicode/screens/utils/theme.dart';

class AllHome extends StatefulWidget {
  AllHome({Key? key}) : super(key: key);

  @override
  _AllHomeState createState() => _AllHomeState();
}

class _AllHomeState extends State<AllHome> {
  List widgetbotton = [
    Home(),
    Favorite(),
    Courses(),
    Profile(),
  ];
  int _selectedIndex = 0;

  void _onItemTapped(int index) async{
    if (Hive.isBoxOpen('user') && index == 3) {
      setState(() {
      _selectedIndex = index;
    });
    } else {
      await Hive.openBox<UserHive>('user');
      setState(() {
      _selectedIndex = index;
    });
    }
  }

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive(context);
    return Scaffold(
      body: widgetbotton.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
          width: responsive.width,
          height: 58,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: bottomnav.length,
              itemBuilder: (_, index) {
                return GestureDetector(
                  onTap: () => _onItemTapped(index),
                  child: Container(
                    width: responsive.wp(25),
                    child:  Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  bottomnav[index]["icon"],
                                  color: _selectedIndex == index
                                      ? UniCode.defaultTheme.primaryColor
                                      : UniCode.gray2,
                                ),
                                Text(
                                  bottomnav[index]["label"],
                                  style: TextStyle(
                                    color: _selectedIndex == index
                                        ? UniCode.defaultTheme.primaryColor
                                        : UniCode.gray2,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                    
                  ),
                  
                );
              })),
    );
  }
}
