import 'dart:developer';

import 'package:SuperStore/models/product.dart';
import 'package:SuperStore/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_add_to_cart_button/flutter_add_to_cart_button.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  ThemeModel appTheme;

  ProductDetailScreen({
    Key? key,
    required this.product,
    required this.appTheme
  }) : super(key: key);



  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {

  AddToCartButtonStateId stateId = AddToCartButtonStateId.idle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text(widget.product.title),
        backgroundColor: widget.appTheme.bottomBarColor,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Hero(
            tag: 'product_image_${widget.product.id}', // Usa el mismo tag para la imagen
            child: Container(
              height: 300.0,
              child: Image.network(
                widget.product.image,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: widget.appTheme.backgroundColor,
              child: Padding(
                padding: const EdgeInsets.all(22.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Hero(
                      tag: 'product_title_${widget.product.id}', // Nuevo tag para el título
                      child: Text(
                        widget.product.title,
                        style: TextStyle(
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold,
                            color: widget.appTheme.primaryTextColor),
                      ),
                    ),
                    Row(
                      children: [
                        Hero(
                          tag: 'product_price_${widget.product.id}', // Nuevo tag para el precio
                          child: Container(
                            margin: const EdgeInsetsDirectional.symmetric(vertical: 12),
                            child: Text(
                              '\$${widget.product.price.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 25.0,
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.star,
                                size: 22.0,
                                color: Colors.orange,
                              ),
                              Text(
                                '${widget.product.rating.rate}',
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Text(
                          widget.product.description,
                          style: TextStyle(
                              fontSize: 18.0,
                              color: widget.appTheme.primaryTextColor),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsetsDirectional.symmetric(vertical: 10),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: AddToCartButton(
                            trolley: Container(
                              child: const Icon(
                                  Icons.shopping_cart,
                                  color: Colors.white,
                              ),
                            ),
                            text: const Text(
                              'Añadir al carrito',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                            ),
                            check: const SizedBox(
                              width: 48,
                              height: 48,
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                            borderRadius: BorderRadius.circular(24),
                            backgroundColor: Colors.deepPurpleAccent,
                            onPressed: (id) {
                              if (id == AddToCartButtonStateId.idle) {
                                //handle logic when pressed on idle state button.
                                setState(() {
                                  stateId = AddToCartButtonStateId.loading;
                                  Future.delayed(Duration(seconds: 3), () {
                                    setState(() {
                                      stateId = AddToCartButtonStateId.done;
                                    });
                                  });
                                });
                              } else if (id == AddToCartButtonStateId.done) {
                                //handle logic when pressed on done state button.
                                setState(() {
                                  stateId = AddToCartButtonStateId.idle;
                                });
                              }
                            },
                            stateId: stateId,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
