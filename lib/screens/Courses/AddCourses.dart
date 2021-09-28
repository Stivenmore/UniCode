import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:unicode/data/HomeRepository.dart';
import 'package:unicode/screens/utils/StreamValidator.dart';
import 'package:unicode/screens/utils/responsive.dart';
import 'package:unicode/screens/utils/theme.dart';

class AddCourses extends StatefulWidget {
  AddCourses({Key? key}) : super(key: key);

  @override
  _AddCoursesState createState() => _AddCoursesState();
}

class _AddCoursesState extends State<AddCourses> {
  final letravalidate = LetraValidate();
  File? image;
  TextEditingController namecurses = TextEditingController();
  TextEditingController nivel = TextEditingController();
  TextEditingController descripcion = TextEditingController();
  TextEditingController nombre = TextEditingController();
  TextEditingController url = TextEditingController();


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
                                          provider[index].namecurse!,
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
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => getGallery(),
                    child: Container(
                      height: 210,
                      width: 160,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: UniCode.defaultTheme.accentColor,
                          border: Border.all(
                              color: UniCode.defaultTheme.primaryColor)),
                      child: image == null
                          ? Icon(
                              Icons.add_a_photo,
                              size: 36,
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.file(
                                image!,
                                height: 210,
                                width: 160,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  StreamBuilder(
                      stream: letravalidate.namecurseStream,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        return TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          onChanged: letravalidate.changenamecurse,
                          controller: namecurses,
                          scrollPadding: EdgeInsets.all(0.0),
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800)),
                          cursorColor: Theme.of(context).primaryColor,
                          decoration: InputDecoration(
                            labelText: 'Nombre del curso',
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
                              borderSide: BorderSide(
                                  color: UniCode.defaultTheme.primaryColor),
                            ),
                            focusColor: UniCode.gray2,
                            fillColor: UniCode.gray2,
                          ),
                          validator: (String? value) => value!.isEmpty
                              ? 'Ingresa tu nombre del curso'
                              : null,
                        );
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  StreamBuilder(
                      stream: letravalidate.nivelStream,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        return TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          onChanged: letravalidate.changenivel,
                          controller: nivel,
                          scrollPadding: EdgeInsets.all(0.0),
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800)),
                          cursorColor: Theme.of(context).primaryColor,
                          decoration: InputDecoration(
                            labelText: 'Nivel del curso',
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
                              borderSide: BorderSide(
                                  color: UniCode.defaultTheme.primaryColor),
                            ),
                            focusColor: UniCode.gray2,
                            fillColor: UniCode.gray2,
                          ),
                          validator: (String? value) =>
                              value!.isEmpty ? 'Ingresa el nivel' : null,
                        );
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  StreamBuilder(
                      stream: letravalidate.descripcionStream,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        return TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          onChanged: letravalidate.changedescripcionr,
                          controller: descripcion,
                          scrollPadding: EdgeInsets.all(0.0),
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800)),
                          cursorColor: Theme.of(context).primaryColor,
                          decoration: InputDecoration(
                            labelText: 'Descripcion del curso',
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
                              borderSide: BorderSide(
                                  color: UniCode.defaultTheme.primaryColor),
                            ),
                            focusColor: UniCode.gray2,
                            fillColor: UniCode.gray2,
                          ),
                          validator: (String? value) =>
                              value!.isEmpty ? 'Ingresa la descripcion' : null,
                        );
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Capitulos',
                      style: TextStyle(
                          color: UniCode.defaultTheme.primaryColor,
                          fontSize: 22,
                          fontWeight: FontWeight.w700)),
                  const SizedBox(
                    height: 20,
                  ),
                  StreamBuilder(
                      stream: letravalidate.nombreStream,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        return TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          onChanged: letravalidate.changenombre,
                          controller: nombre,
                          scrollPadding: EdgeInsets.all(0.0),
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800)),
                          cursorColor: Theme.of(context).primaryColor,
                          decoration: InputDecoration(
                            labelText: 'Nombre del primer capitulo',
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
                              borderSide: BorderSide(
                                  color: UniCode.defaultTheme.primaryColor),
                            ),
                            focusColor: UniCode.gray2,
                            fillColor: UniCode.gray2,
                          ),
                          validator: (String? value) =>
                              value!.isEmpty ? 'Ingresa el nombre primer capitulo' : null,
                        );
                      }),
                      const SizedBox(
                    height: 20,
                  ),
                  StreamBuilder(
                      stream: letravalidate.urlStream,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        return TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          onChanged: letravalidate.changeurl,
                          controller: url,
                          scrollPadding: EdgeInsets.all(0.0),
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800)),
                          cursorColor: Theme.of(context).primaryColor,
                          decoration: InputDecoration(
                            labelText: 'Url del primer capitulo',
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
                              borderSide: BorderSide(
                                  color: UniCode.defaultTheme.primaryColor),
                            ),
                            focusColor: UniCode.gray2,
                            fillColor: UniCode.gray2,
                          ),
                          validator: (String? value) =>
                              value!.isEmpty ? 'Ingresa la url del primer capitulo' : null,
                        );
                      }),
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }

  Future getGallery() async {
    //aqui tomo la imagen de galeria
    final currentImage = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 100);
    if (currentImage != null) {
      setState(() {
        image = File(currentImage.path);
      });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('No se pudo tomar la imagen')));
    }
  }
}
