import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:unicode/data/HomeRepository.dart';
import 'package:unicode/domain/Models/Normals/modelallCourses.dart';
import 'package:unicode/screens/utils/StreamValidator.dart';
import 'package:unicode/screens/utils/responsive.dart';
import 'package:unicode/screens/utils/theme.dart';

class AddCap extends StatefulWidget {
  AddCap({Key? key}) : super(key: key);

  @override
  _AddCapState createState() => _AddCapState();
}

class _AddCapState extends State<AddCap> {
  String texto = 'Buscando tus cursos';
  int? currentindex;
  AllCoursesModel? allCoursesModel;
  final letravalidate = AddCapValidate();
  TextEditingController nombre = TextEditingController();
  TextEditingController url = TextEditingController();
  final RoundedLoadingButtonController controller =
      RoundedLoadingButtonController();
  HomeRepository homeRepository = HomeRepository();
  String? urltext;


  @override
  void initState() {
        Future.delayed(Duration(seconds: 2), () {
      setState(() {
        texto = 'Buscando tus cursos';
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
    final provider = Provider.of<HomeRepository>(context).allcoursesModel;
    Responsive responsive = Responsive(context);
    return Scaffold(
        body: Container(
      height: responsive.height,
      width: responsive.width,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Elige el curso al que deseas agregar capitulos',
                style: GoogleFonts.lato(
                    textStyle: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w800)),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 200,
              child: provider.length > 0
                  ? CustomScrollView(
                      scrollDirection: Axis.horizontal,
                      slivers: [
                        SliverGrid(
                          delegate: SliverChildBuilderDelegate((_, index) {
                            return Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    currentindex = index;
                                    allCoursesModel = provider[index];
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                          color: currentindex == index
                                              ? UniCode
                                                  .defaultTheme.primaryColor
                                              : Colors.white)),
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
                                                color: Colors.white,
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
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
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
                              ? 'Ingresa el nombre capitulo'
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
                          onChanged: (value) {
                            letravalidate.changeurl(value);
                            setState(() {
                              urltext = value;
                            });
                          },
                          controller: url,
                          scrollPadding: EdgeInsets.all(0.0),
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800)),
                          cursorColor: Theme.of(context).primaryColor,
                          decoration: InputDecoration(
                            labelText: 'Url del capitulo',
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
                              ? 'Ingresa la url del capitulo'
                              : null,
                        );
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: StreamBuilder(
                    stream: letravalidate.formValidStream,
                    builder: (context, snapshot) {
                      return RoundedLoadingButton(
                          color: UniCode.defaultTheme.primaryColor,
                          controller: controller,
                          onPressed: () async {
                            if (snapshot.hasData &&
                                allCoursesModel != null &&
                                url.text != '') {
                              final resp = await homeRepository.setnewCap(
                                description: allCoursesModel!.descripcion!,
                                nivel: allCoursesModel!.nivel!,
                                namecurse: allCoursesModel!.namecurse!,
                                imagepromotion:
                                    allCoursesModel!.imagepromotion!,
                                nombre: nombre.text,
                                url: urltext!,
                              );
                              if (resp) {
                                Timer(Duration(milliseconds: 700), () {
                                  controller.success();
                                  nombre.clear();
                                  url.clear();
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
              ),
            ),
          )
        ],
      ),
    ));
  }
}
