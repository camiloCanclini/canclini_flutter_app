import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:canclini_flutter_app/screens/UserProfileScreen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio'),
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
                  MaterialPageRoute(builder: (context) => UserProfileScreen()),
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