import 'dart:convert';

import 'package:canclini_flutter_app/common_widgets/general/general_common_widgets_barrel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../providers/theme_provider.dart';

class CreditCardsCarouselWidget extends StatelessWidget {

  CreditCardsCarouselWidget({super.key});

  final List<Map<String, dynamic>> creditCardsList = [
    {'imagePath': 'assets/images/home_screen/credit_cards_carousel/1.png',
      'title': '25% Dto', 'subTitle': 'Tope : \$ 4.000 en la primera compra',
      'description': 'Con Tarjeta de Credito *Comprando cualquier dia y programando entrega/retiro el dia de la promo.'
    },
    {
      'imagePath': 'assets/images/home_screen/credit_cards_carousel/2.png',
      'title': '5% Dto',
      'subTitle': 'Tope : \$ 1.000 por usuario',
      'description': 'Del 01/05/2023 al 31/01/2024. En tu primer pago con Mercado Credito'
    },
    {
      'imagePath': 'assets/images/home_screen/credit_cards_carousel/3.png',
      'title': '15% Dto',
      'subTitle': 'Tope \$ 1.500 por transacción',
      'description': 'Comprando con tarjeta de crédito ONLINE: comprando cualquier día y programando entrega/retiro los días de la promo'
    },
  ];

  @override
  Widget build(BuildContext context) {
    ThemeModel appTheme = Provider
        .of<ThemeProvider>(context)
        .themeModel;

    return CarouselSlider.builder(
      itemCount: creditCardsList.length,
      itemBuilder: (context, index, realIndex) {
        final creditCard = creditCardsList[index];
        return _CreditCardWidget(
            imagePath: creditCard["imagePath"],
            title: creditCard["title"],
            subTitle: creditCard["subTitle"],
            description: creditCard["description"]
        );
      },
      options: CarouselOptions(
        height: double.infinity,
        viewportFraction: 1,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 6),
        autoPlayAnimationDuration: const Duration(milliseconds: 1000),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: false,
        scrollDirection: Axis.horizontal,
      ),
    );
  }

}

class _CreditCardWidget extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subTitle;
  final String description;

  const _CreditCardWidget(
      {required this.imagePath, required this.title, required this.subTitle, required this.description});

  @override
  Widget build(BuildContext context) {
    ThemeModel appTheme = Provider
        .of<ThemeProvider>(context)
        .themeModel;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: appTheme.cardShadowColor, // Color de la sombra
            blurRadius: 20.0, // Radio de desenfoque
            spreadRadius: 0, // Extensión de la sombra
            offset: Offset(0, 4), // Desplazamiento de la sombra (eje x, eje y)
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [
                appTheme.cardSecondaryBackgroundColor,
                appTheme.cardBackgroundColor,
              ],
              radius: 0.8, // Ajusta el radio según tus preferencias
              center: Alignment.center, // Ajusta el centro según tus preferencias
            ),
          ),
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              Image.asset(
                width: double.infinity,
                height: 100,
                imagePath,
                fit: BoxFit.contain,
              ),
              Text(
                title,
                style: GoogleFonts.oswald(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: appTheme.primaryTextColor,
                ),
              ),
              Text(
                subTitle,
                style: GoogleFonts.barlow(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: appTheme.primaryTextColor,
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      description,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.dosis(
                        color: appTheme.primaryTextColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }

}