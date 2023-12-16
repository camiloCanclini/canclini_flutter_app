import 'package:canclini_flutter_app/common_widgets/app_bar.dart';
import 'package:canclini_flutter_app/services/store_api/products.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import '../common_widgets/drawer_menu.dart';
import '../models/product.dart';

class ProductsScreen extends StatelessWidget {

  ProductsScreen({super.key});

  ProductsService service = ProductsService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerMenu(),
      appBar: MyAppBar(titleAppBar: 'Productos'),
      body: Center(
        child: FutureBuilder<List<Product>>(
          future: service.getAllProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // Muestra un indicador de carga mientras se obtienen los datos
            } else if (snapshot.hasError) {
              return Text('Error al cargar los productos'); // Muestra un mensaje si ocurre un error
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text('No hay productos disponibles'); // Muestra un mensaje si no hay datos
            } else {
              // Muestra el ListView con los datos obtenidos
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final Product product = snapshot.data![index];
                  return Card(
                    margin: EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: product.image,
                        fit: BoxFit.cover,
                        width: 80.0,
                        height: 80.0,
                      ),
                      title: Text(product.title),
                      subtitle: Text('\$ ${product.price.toString()}'),
                      // Agrega más widgets para mostrar otros detalles del producto si es necesario
                    ),
                  );
                },
              );
            }
          },
        )
      ),
    );
  }


}