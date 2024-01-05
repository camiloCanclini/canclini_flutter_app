import 'package:canclini_flutter_app/screens/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helpers/secure_storage_helper.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Expanded(
                  child: Column(
                    children: [
                      Text('Nombre del usuario'),
                      Text('Mas Info'),
                    ],
                  )
              ),
              Container(
                width: double.infinity,
                color: Color.fromARGB(20, 255, 0, 0),
                child: TextButton(
                  onPressed: () {
                    _logoutUser(context);
                  },
                  child: const Text('Salir de la cuenta',
                    style: TextStyle(color: Colors.red, fontSize: 15.5),
                  ),
                ),
              )
                  
                ]
            )
        )
    );
  }

  // Función para mostrar la alerta al usuario
  Future<void> _logoutUser(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // Evita que se cierre al tocar fuera del dialogo
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('¿Confirmar acción?'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('¿Está seguro de querer realizar esta acción?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Sí'),
              onPressed: () async {
                await SecureStorage.deleteToken(); // Guardar el token en SecureStorage
                if(context.mounted){
                  Navigator.of(context).pushNamedAndRemoveUntil('login', (route) => false);
                }
              },
            ),
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}