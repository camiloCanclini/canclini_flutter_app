import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../helpers/common_methods/heroTextFixer.dart';
import '../../../models/product.dart';
import '../../../providers/theme_provider.dart';
import '../../product_detail_screen.dart';


class ProductWidget extends StatelessWidget {
  final Product product;

  const ProductWidget({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeModel appTheme =
        Provider.of<ThemeProvider>(context, listen: true).themeModel;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return FadeTransition(
                opacity: animation,
                child: ProductDetailScreen(
                  product: product,
                  appTheme: appTheme,
                ),
              );
            },
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              const begin = 0.0;
              const end = 1.0;
              var curve = Curves.easeInOut;
              var tween = Tween(begin: begin, end: end).chain(
                CurveTween(curve: curve),
              );

              var fadeAnimation = animation.drive(tween);
              return FadeTransition(opacity: fadeAnimation, child: child);
            },
          ),
        );
      },
      child: SizedBox(
        height: 300,
        width: 20,
        child: Card(
          elevation: 5.0,
          color: appTheme.cardBackgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Hero(
                  tag: 'product_image_${product.id}',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: product.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Hero(
                      flightShuttleBuilder: flightShuttleBuilder,
                      tag: 'product_title_${product.id}',
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          product.title,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: appTheme.primaryTextColor,
                          ),
                        ),
                      ),
                    ),
                    Hero(
                      tag: 'product_price_${product.id}',
                      flightShuttleBuilder: flightShuttleBuilder,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(
                          '\$${product.price.toStringAsFixed(2)}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 15.0,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ClipOval(
                            child: InkWell(
                              onTap: () => "sd",
                              child: Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Icon(
                                  Icons.bookmark,
                                  size: 22.0,
                                  color: appTheme.primaryTextColor,
                                ),
                              ),
                            ),
                          ),
                          ClipOval(
                            child: InkWell(
                              onTap: () => "sd",
                              child: Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Icon(
                                  Icons.add_shopping_cart,
                                  size: 22.0,
                                  color: appTheme.primaryTextColor,
                                ),
                              ),
                            ),
                          ),
                        ],
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
