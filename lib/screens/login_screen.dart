// Esta sería la pantalla de inicio de sesión
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
        title: const Text('Store App Login'),
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
              child: const Text('Iniciar sesión'),
            ),
            TextButton(
              onPressed: () {

              },
              child: const Text('Registrarse'),
            ),
          ],
        ),
      ),
    );
  }

  void _loginUser(BuildContext context) async {
    final String apiUrl = dotenv.env['API_URL']!;
    try {
      final Map<String, String> data = {
        'email': _emailController.text,
        'password': _passwordController.text,
      };
      final http.Response response = await http.post(
        Uri.parse('$apiUrl/register'),
        body: json.encode(data),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final String token = responseData['apiKey'];
        //print(token);
        await SecureStorage.saveToken(token);
        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        }
      } else {
        if (context.mounted) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Fallo al iniciar sesión'),
              content: const Text('Credenciales incorrectas. Inténtalo de nuevo.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
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
      //print('Error: $e');
    }
  }
}



// W I D G E T S  A L E R T A S

// Función para mostrar el diálogo de éxito

// Función para mostrar el diálogo de error
