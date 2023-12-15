// Esta sería la pantalla de inicio de sesión
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../helpers/secure_storage_helper.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Store App Login'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Correo electrónico',
                border: OutlineInputBorder(),
              ),
              controller: _emailController,
            ),
            const SizedBox(height: 20),
            TextField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Contraseña',
                border: OutlineInputBorder(),
              ),
              controller: _passwordController,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _loginUser(context);
              },
              child: Text('Iniciar sesión'),
            ),
            TextButton(
              onPressed: () {
                // Lógica para ir a la pantalla de registro
              },
              child: Text('Registrarse'),
            ),
          ],
        ),
      ),
    );
  }

  void _loginUser(BuildContext context) async {
    const String apiUrl = 'https://canclini-express-api.onrender.com/register';

    try {
      final Map<String, String> data = {
        'email': _emailController.text,
        'password': _passwordController.text,
      };

      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        body: json.encode(data),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final String token = responseData['apiKey'];
        await SecureStorage.saveToken(token); // Guardar el token en SecureStorage

        // Redirigir a la pantalla principal
        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        }
      } else {
        if (context.mounted) {
          // Mostrar un mensaje de error si las credenciales son incorrectas
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Fallo al iniciar sesión'),
              content: const Text('Credenciales incorrectas. Inténtalo de nuevo.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Cerrar el diálogo
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
        }
      }
    } catch (e) {
      // Manejar errores
      print('Error: $e');
    }
  }
}



// W I D G E T S  A L E R T A S

// Función para mostrar el diálogo de éxito
void _showLoginSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('¡Inicio de sesión exitoso!'),
        content: Text('Ahora estás conectado.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Cerrar el diálogo
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}

// Función para mostrar el diálogo de error
void _showErrorDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Error en el inicio de sesión'),
        content: Text('Ocurrió un error al iniciar sesión. Por favor, inténtalo de nuevo.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Cerrar el diálogo
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}