import 'package:SuperStore/providers/theme_provider.dart';
import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../helpers/secure_storage_helper.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {

    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DayNightSwitcher(
                      isDarkModeEnabled: themeProvider.isDarkMode,
                      onStateChanged: themeProvider.toggleTheme,
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsetsDirectional.symmetric(horizontal: 50),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Color.fromARGB(20, 255, 0, 0),
                ),
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
    return QuickAlert.show(
      context: context,
      type: QuickAlertType.warning,
      showCancelBtn: true,
      text: 'Estas Seguro Que Deseas Esto?',
      title: "Desconectarse...",
      onCancelBtnTap: () async {
        await SecureStorage.deleteToken(); // Guardar el token en SecureStorage
        if(context.mounted){
          Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
        }
      },
      confirmBtnText: 'No',
      cancelBtnText: 'Si',
      confirmBtnColor: Colors.deepPurpleAccent,
    );

  }
}