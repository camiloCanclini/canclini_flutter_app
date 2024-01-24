import 'dart:convert';

import 'package:canclini_flutter_app/common_widgets/general/general_common_widgets_barrel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class OffersCarouselWidget extends StatelessWidget{

  const OffersCarouselWidget({super.key});

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<List<String>>(
      future: loadAssetImages(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const Center(
              child: ErrorLoadWidget(
                messageText: "Ocurrió un error cargando las imagenes",
              ),
            );
          }

          final List<String>? imagePaths = snapshot.data;

          return CarouselSlider.builder(
            itemCount: imagePaths!.length,
            itemBuilder: (context, index, realIndex) {
              final imagePath = imagePaths[index];
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
            options: CarouselOptions(
              aspectRatio: 16 / 9,
              viewportFraction: 1,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              scrollDirection: Axis.vertical,
            ),
          );
        } else {
          return const Center(
            child: LoadingThreeDotsWidget(),
          );
        }
      },
    );
  }

  Future<List<String>> loadAssetImages() async {
    // Obtener la lista de archivos en la carpeta assets
    final assetDir = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(assetDir);
    final List<String> imagePaths = manifestMap.keys
        .where((String key) =>
        key.startsWith('assets/images/home_screen/offers_carousel/'))
        .toList();

    return imagePaths;
  }
}