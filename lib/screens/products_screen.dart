import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:canclini_flutter_app/screens/user_profile_screen.dart';

import '../common_widgets/DrawerMenu.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerMenu(),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Products'),
        actions: [
          SizedBox(
            width: 50,
            height: 50,
            child: IconButton(
              icon: const Icon(Icons.account_circle),
              color: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UserProfileScreen()),
                );
              },

            ),
          )
        ],
      ),
      body: const Center(
        child: Text('Bienvenido!'),
      ),
    );
  }
}