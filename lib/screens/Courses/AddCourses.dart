import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
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
  String texto = 'Buscando tus cursos';
  final RoundedLoadingButtonController controller =
      RoundedLoadingButtonController();
  HomeRepository homeRepository = HomeRepository();
  final letravalidate = LetraValidate();
  File? image;
  TextEditingController namecurses = TextEditingController();
  TextEditingController nivel = TextEditingController();
  TextEditingController descripcion = TextEditingController();
  TextEditingController nombre = TextEditingController();
  TextEditingController url = TextEditingController();

  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        texto = 'Buscando';
      });
    });
    Future.delayed(Duration(seconds: 7), () {
      setState(() {
        texto = 'Aun no logramos encontrar tus cursos';
      });
    });
    Future.delayed(Duration(seconds: 11), () {
      setState(() {
        texto = 'No logramos encontrar tus cursos';
      });
    });
    super.initState();
  }

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
              child: provider.isNotEmpty
                  ? CustomScrollView(
                      scrollDirection: Axis.horizontal,
                      slivers: [
                        SliverGrid(
                          delegate: SliverChildBuilderDelegate((_, index) {
                            return Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: GestureDetector(
                                onTap: () {},
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
                                            placeholder: AssetImage(
                                                'assets/no-image.jpg'),
                                            image: NetworkImage(provider[index]
                                                .imagepromotion!),
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
                                                color: UniCode.defaultTheme.primaryColor,
                                                fontSize: 20),
                                            overflow: TextOverflow.fade,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }, childCount: provider.length),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1),
                        )
                      ],
                    )
                  : Container(
                      height: 200,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 70,
                          ),
                          Text(texto),
                          const SizedBox(
                            height: 20,
                          ),
                          CircularProgressIndicator(
                            color: UniCode.defaultTheme.primaryColor,
                          ),
                        ],
                      ),
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
                          validator: (String? value) => value!.isEmpty
                              ? 'Ingresa el nombre primer capitulo'
                              : null,
                        );
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  StreamBuilder(
                      stream: letravalidate.urlStream,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        return TextFormField(
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
                          validator: (String? value) => value!.isEmpty
                              ? 'Ingresa la url del primer capitulo'
                              : null,
                        );
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: StreamBuilder(
                        stream: letravalidate.formValidStream,
                        builder: (context, snapshot) {
                          return RoundedLoadingButton(
                              color: UniCode.defaultTheme.primaryColor,
                              controller: controller,
                              onPressed: () async {
                                if (snapshot.hasData && image != null) {
                                  final resp =
                                      await homeRepository.setMeCourses(
                                          description: descripcion.text,
                                          imagepromotion: image!,
                                          nivel: nivel.text,
                                          nombre: nombre.text,
                                          url: url.text,
                                          namecurse: namecurses.text);
                                  if (resp) {
                                    descripcion.clear();
                                    setState(() {
                                      image = null;
                                    });
                                    nivel.clear();
                                    nombre.clear();
                                    url.clear();
                                    namecurses.clear();
                                    Timer(Duration(milliseconds: 700), () {
                                      controller.success();
                                    });
                                    Timer(Duration(milliseconds: 1400), () {
                                      controller.reset();
                                    });
                                  } else {
                                    Timer(Duration(milliseconds: 700), () {
                                      controller.error();
                                    });
                                    Timer(Duration(milliseconds: 1400), () {
                                      controller.reset();
                                    });
                                  }
                                } else {
                                  Timer(Duration(milliseconds: 700), () {
                                    controller.error();
                                  });
                                  Timer(Duration(milliseconds: 1400), () {
                                    controller.reset();
                                  });
                                }
                              },
                              child: Text('Crear curso'));
                        }),
                  )
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
