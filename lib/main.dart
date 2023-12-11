
// I M P O R T A C I O N E S
// PROVIDERS
import 'package:canclini_flutter_app/providers/theme_prov.dart';
// HELPERS
import 'package:canclini_flutter_app/helpers/secure_storage_helper.dart';
// FLUTTER
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// DEPENDENCIES
//import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
// SCREENS
import 'package:canclini_flutter_app/screens/home_screen.dart';
import 'package:canclini_flutter_app/screens/login_screen.dart';

void main() async{

  // C O N F I G U R A C I O N E S
  WidgetsFlutterBinding.ensureInitialized();
  //await dotenv.load();
  //await Preferences.initShared();

  // I N I C I A L I Z A C I O N   A P P
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: SecureStorage.isTokenValid(), // Función para verificar la autenticación
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(color: Colors.indigoAccent, valueColor: AlwaysStoppedAnimation(Colors.cyan),); // Indicador de carga mientras se verifica la autenticación
        } else {
          if (snapshot.data == true) {
            return MaterialApp(
              // ... Resto de tu MaterialApp con rutas
              home: HomeScreen(), // Mostrar la pantalla principal si está autenticado
            );
          } else {
            return MaterialApp(
              // ... Resto de tu MaterialApp con rutas
              home: LoginScreen(), // Mostrar la pantalla de inicio de sesión si no está autenticado
            );
          }
        }
      },
    );
  }
}