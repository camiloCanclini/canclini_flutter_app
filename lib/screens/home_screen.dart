import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:path_provider/path_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FutureBuilder<List<String>>(
          future: _loadImages(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Text('Error al cargar imágenes');
              }
              if (snapshot.hasData) {
                return CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    aspectRatio: 2,
                    enlargeCenterPage: true,
                    height: 200,
                  ),
                  items: snapshot.data!.map((imagePath) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Padding(
                          padding: const EdgeInsets.all(1),
                          child: Container(
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).viewPadding.top),
                            height: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              image: DecorationImage(
                                image: AssetImage(imagePath),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                );
              }
            }
            return CircularProgressIndicator();
          },
        ),
      ],
    );
  }

  Future<List<String>> _loadImages() async {
    try {
      // Obtiene el directorio de la aplicación
      Directory appDirectory = await getApplicationDocumentsDirectory();
      String imagesPath = 'assets/images/home_screen/main_carousel';

      // Lista de rutas de imágenes en el directorio
      List<String> imagePaths = [];

      // Lee los archivos en el directorio
      List<FileSystemEntity> files = Directory(imagesPath).listSync();

      for (var file in files) {
        if (file is File && file.path.endsWith('.jpg')) {
          imagePaths.add(file.path);
        }
      }

      return imagePaths;
    } catch (e) {
      print('Error al leer imágenes: $e');
      return [];
    }
  }
}
