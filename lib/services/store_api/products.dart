import 'dart:convert';
import 'package:canclini_flutter_app/helpers/secure_storage_helper.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../../models/product.dart';

class ProductsService{


  final String apiUrl = dotenv.env['API_URL']!;

  Future<List<Product>> getAllProducts() async {
    final String? tokenStored = await SecureStorage.getToken();
    if(tokenStored != null){
      final response = await http.get(
          Uri.parse('$apiUrl/products'),
          headers: {"apiKey": tokenStored}
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((product) => Product.fromJson(product)).toList();  // Mapeo la lista de productos obtenida en la respuesta a una lista de objetos Product
      } else {
        throw Exception('Error al cargar los productos');
      }
    }else{
      throw Exception('Error al cargar los productos');
    }

  }

  ProductsService();
}