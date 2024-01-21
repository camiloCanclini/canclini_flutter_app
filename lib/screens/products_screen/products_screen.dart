import 'package:canclini_flutter_app/providers/theme_provider.dart';
import 'package:canclini_flutter_app/screens/products_screen/widgets/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import '../../models/product.dart';
import 'package:transparent_image/transparent_image.dart';
import '../../providers/products_provider.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: FutureBuilder<List<Product>>(
          future: productsProvider.getAllProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return LoadingAnimationWidget.threeRotatingDots(
                color: Colors.white,
                size: 100,
              );
            } else if (snapshot.hasError) {
              return const ErrorWidget(
                  messageText: "Ocurrió un error cargando los articulos!");
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const WarningWidget(
                  messageText: "No hay articulos para mostrar!");
            } else {
              return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AlignedGridView.count(
                    crossAxisCount: 2,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final Product product = snapshot.data![index];
                      return ProductWidget(
                        product: product,
                      );
                    },
                  )
              );
            }
          },
        ),
      ),
    );
  }
}

class ErrorWidget extends StatelessWidget {
  final String messageText;

  const ErrorWidget({super.key, required this.messageText});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.error_rounded, // Icono de carita triste
          size: 150.0, // Tamaño del icono
          color: Colors.white,
          shadows: [
            Shadow(color: Colors.black38, blurRadius: 5, offset: Offset(2, 2))
          ],
          // Color del icono
        ),
        Text(
          messageText,
          style: const TextStyle(color: Colors.white, fontSize: 20, shadows: [
            Shadow(color: Colors.black54, blurRadius: 2, offset: Offset(2, 2))
          ]),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}

class WarningWidget extends StatelessWidget {
  final String messageText;

  const WarningWidget({super.key, required this.messageText});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.production_quantity_limits, // Icono de carita triste
          size: 150.0, // Tamaño del icono
          color: Colors.white,
          shadows: [
            Shadow(color: Colors.black38, blurRadius: 5, offset: Offset(2, 2))
          ],
          // Color del icono
        ),
        Text(
          messageText,
          style: const TextStyle(color: Colors.white, fontSize: 20, shadows: [
            Shadow(color: Colors.black54, blurRadius: 2, offset: Offset(2, 2))
          ]),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
