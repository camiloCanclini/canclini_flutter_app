import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helpers/secure_storage_helper.dart';

class UserProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
        body: Center(
        child: Stack(
        children: <Widget>[
              Text('Nombre del usuario'),
              Text('Mas info'),
              TextButton(
                onPressed: () async {
                  _logoutUser(context);

                },
                child: Text('Registrarse'),
              ),
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
          title: Text('¿Confirmar acción?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('¿Está seguro de querer realizar esta acción?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Sí'),
              onPressed: () async {
                await SecureStorage.deleteToken(); // Guardar el token en SecureStorage
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('No'),
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