// Esta sería la pantalla de inicio de sesión
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../helpers/secure_storage_helper.dart';
import 'package:canclini_flutter_app/services/store_api/users.dart';
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
                login(context);
              },
              child: const Text('Iniciar sesión'),
            ),
            TextButton(
              onPressed: () {
                register(context);
              },
              child: const Text('Registrarse'),
            ),
          ],
        ),
      ),
    );
  }

  void login(BuildContext context) async {
    final String apiUrl = dotenv.env['API_URL']!;
    try {
      final String token = await UserService.loginUser(_emailController.text, _passwordController.text);
      await SecureStorage.saveToken(token);
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    } catch (e) {
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Fallo al iniciar sesión'),
              content: Text(e.toString()),
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
  }

  void register(BuildContext context) async {
    final String apiUrl = dotenv.env['API_URL']!;
    try {
      final String token = await UserService.registerUser(_emailController.text, _passwordController.text);
      await SecureStorage.saveToken(token);
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    } catch (e) {
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Fallo al iniciar sesión'),
              content: Text(e.toString()),
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
  }
}

