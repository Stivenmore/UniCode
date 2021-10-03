import 'dart:io';

abstract class AbstractHome {
  getCourses();

  setMeCourses(
      {required String description,
      required File imagepromotion,
      required String nivel,
      required String nombre,
      required String url,
      required String namecurse});
  
  getallcourses();

  setnewCap({required String description,
  required String imagepromotion,
      required String nivel,
      required String namecurse,
       required String nombre,
        required String url});
}
