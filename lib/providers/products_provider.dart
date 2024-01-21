import 'package:flutter/cupertino.dart';

import '../models/product.dart';
import '../services/store_api/products.dart';

class ProductsProvider extends ChangeNotifier {
  ProductsService service = ProductsService();
  List<Product>? _products;

  Future<List<Product>> getAllProducts() async {
    _products ??= await service.getAllProducts();
    return _products!;
  }

// Agrega métodos adicionales según sea necesario
}