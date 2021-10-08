import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:unicode/data/HomeRepository.dart';
import 'package:unicode/domain/Models/Normals/modelallCourses.dart';
import 'package:unicode/screens/utils/responsive.dart';
import 'package:unicode/screens/utils/theme.dart';

List<AllCoursesModel> allcoursesModel = [];
List<AllCoursesModel> coursesbyquery = [];

class SearchCourseDelegate extends SearchDelegate {
  @override
  String get searchFieldLabel => 'Buscar curso por nombre';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = '',
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('buildResults');
  }

  Widget _emptyContainer() {
    return Container(
      child: Center(
        child: Icon(
          Icons.movie_creation_outlined,
          color: Colors.black38,
          size: 130,
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    Responsive responsive = Responsive(context);
    if (query.isEmpty) {
      return _emptyContainer();
    }
    Provider.of<HomeRepository>(context).getallCoursesGeneral();
    allcoursesModel =
        Provider.of<HomeRepository>(context, listen: true).allcoursesgeneral;
    onSearch(String query) {
      coursesbyquery = allcoursesModel
          .where((element) => element.namecurse!.contains(query.toUpperCase()))
          .toList();
      return coursesbyquery;
    }

    return onSearch(query).isNotEmpty
        ? ListView.builder(
            itemCount: onSearch(query).length,
            itemBuilder: (_, index) {
              return Padding(
                padding: const EdgeInsets.all(14.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: FadeInImage(
                        height: 100,
                        width: 60,
                        placeholder: AssetImage('assets/no-image.jpg'),
                        image: NetworkImage(
                            onSearch(query)[index].imagepromotion!),
                        fit: BoxFit.fill,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            width: responsive.wp(60),
                            child: Text(
                              onSearch(query)[index].namecurse!,
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: UniCode.defaultTheme.primaryColor,
                                      fontWeight: FontWeight.bold)),
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: responsive.wp(60),
                            child: Text(
                              onSearch(query)[index].descripcion!,
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: UniCode.defaultTheme.primaryColor,
                                      fontWeight: FontWeight.bold)),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            width: responsive.wp(60),
                            child: Text(
                              onSearch(query)[index].tutor!,
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: UniCode.defaultTheme.primaryColor,
                                      fontWeight: FontWeight.bold)),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            width: responsive.wp(60),
                            child: Text(
                            //  onSearch(query)[index].publicado == null? '': 'Publicado el ${onSearch(query)[index].publicado}',
                            '',
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: UniCode.defaultTheme.primaryColor,
                                      fontWeight: FontWeight.bold)),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            width: responsive.wp(60),
                            child: Text(
                              'Nivel: ${onSearch(query)[index].nivel!}',
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: UniCode.defaultTheme.primaryColor,
                                      fontWeight: FontWeight.bold)),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            })
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 400,
              child: Center(
                child: Text(
                  'No hemos logrado encontrar cursos con este nombre :(',
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: UniCode.defaultTheme.primaryColor,
                          fontSize: 22)),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
  }
}

class Search extends StatefulWidget {
  Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Search', style: TextStyle(fontSize: 22)),
      ),
    );
  }
}
