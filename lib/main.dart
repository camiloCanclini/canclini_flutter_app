
// I M P O R T A C I O N E S
// PROVIDERS
// HELPERS
import 'package:canclini_flutter_app/helpers/secure_storage_helper.dart';
import 'package:canclini_flutter_app/screens/products_screen.dart';
// FLUTTER
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_dropdown_alert/dropdown_alert.dart';
// DEPENDENCIES
//import 'package:flutter_dotenv/flutter_dotenv.dart';
// SCREENS
import 'package:canclini_flutter_app/screens/home_screen.dart';
import 'package:canclini_flutter_app/screens/login_screen.dart';


void main() async{

  // C O N F I G U R A C I O N E S
  WidgetsFlutterBinding.ensureInitialized();
  //await dotenv.load();
  //await Preferences.initShared();

  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

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
      home: isLoggedIn ? const HomeScreen() : const LoginScreen(),
      theme: ThemeData(
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      builder: (context, child) => Stack(
        children: [
          child!,
          const DropdownAlert(position: AlertPosition.BOTTOM, delayDismiss: 10000, showCloseButton: true,)
        ],
      ),
      //navigatorObservers: [AuthenticationNavigator()],
      routes: {
        'login': (context) => const LoginScreen(),
        'home': (context) => const HomeScreen(),
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