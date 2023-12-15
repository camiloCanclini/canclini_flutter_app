
// I M P O R T A C I O N E S
// PROVIDERS
import 'package:canclini_flutter_app/providers/theme_prov.dart';
// HELPERS
import 'package:canclini_flutter_app/helpers/secure_storage_helper.dart';
import 'package:canclini_flutter_app/screens/products_screen.dart';
// FLUTTER
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// DEPENDENCIES
//import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
// SCREENS
import 'package:canclini_flutter_app/screens/home_screen.dart';
import 'package:canclini_flutter_app/screens/login_screen.dart';

import 'helpers/observers/AuthenticationNavigator.dart';

void main() async{

  // C O N F I G U R A C I O N E S
  WidgetsFlutterBinding.ensureInitialized();
  //await dotenv.load();
  //await Preferences.initShared();

  WidgetsFlutterBinding.ensureInitialized();

  // Aquí deberías realizar la lógica de verificación de credenciales
  bool isLoggedIn = await SecureStorage.isTokenValid(); // Esta función debería verificar las credenciales

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {

  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: isLoggedIn ? const HomeScreen() : const LoadingScreen(),
      navigatorObservers: [AuthenticationNavigator()],
      routes: {
        'login': (context) => LoginScreen(),
        'home': (context) => HomeScreen(),
        'products': (context) => ProductsScreen()
      },
    );
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}