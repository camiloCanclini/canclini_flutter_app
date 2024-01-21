import 'package:flutter/material.dart';
import 'package:flutter_dropdown_alert/alert_controller.dart';
import 'package:flutter_dropdown_alert/model/data_alert.dart';

import '../../../helpers/secure_storage_helper.dart';
import '../../../services/store_api/users.dart';

class LoginForm extends StatefulWidget {
  final bool showLoginFormState;
  final Function(bool) updateShowLoginFormState;
  final Function(bool) updateShowRegisterFormState;
  final Function(bool) updateShowLoadingState;

  const LoginForm({
    Key? key,
    required this.showLoginFormState,
    required this.updateShowLoginFormState,
    required this.updateShowRegisterFormState,
    required this.updateShowLoadingState,
  }) : super(key: key);

  @override
  State createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm>{
  bool _hidePass = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  AnimatedContainer(
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
      transform: Matrix4.translationValues(
        0.0,
        widget.showLoginFormState ? 0.0 : MediaQuery.of(context).size.height,
        0.0,
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(60),
            topRight: Radius.circular(60),
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.deepPurple[100]!,
                            blurRadius: 5,
                            offset: const Offset(0, 5))
                      ]),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.grey[200]!))),
                        child: TextField(
                          cursorColor: Colors.deepPurple,
                          controller: _emailController,
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.alternate_email_rounded),
                              hintText: "E-mail",
                              hintStyle:
                              TextStyle(color: Colors.grey),
                              border: InputBorder.none),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.deepPurple[100]!,
                            blurRadius: 5,
                            offset: const Offset(0, 5))
                      ]),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.grey[200]!))),
                        child: TextField(
                          cursorColor: Colors.deepPurple,
                          controller: _passwordController,
                          obscureText: _hidePass,
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.password),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _hidePass ? Icons.visibility : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _hidePass = !_hidePass;
                                  });
                                },
                              ),
                              hintText: "Password",
                              hintStyle:
                              const TextStyle(color: Colors.grey),
                              border: InputBorder.none),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                //const Text("Forgot Password?", style: TextStyle(color: Colors.black38),),
                const SizedBox(height: 20.0),
                TextButton(
                  onPressed: () {
                    login(context);
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<
                        EdgeInsetsGeometry>(EdgeInsets.zero),
                    shape:
                    MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    backgroundColor:
                    MaterialStateProperty.all<Color>(
                        Colors.deepPurple[300]!),
                  ),
                  child: Container(
                    height: 50,
                    width: 120,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 50),
                    child: const Center(
                      child: Text(
                        "Ingresar",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus(); // Oculta el teclado
                    widget.updateShowLoginFormState(false);
                    Future.delayed(const Duration(milliseconds: 300), () => widget.updateShowRegisterFormState(true));
                    _emailController.clear();
                    _passwordController.clear();
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<
                        EdgeInsetsGeometry>(EdgeInsets.zero),
                    shape:
                    MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                            color: Colors.deepPurple[200]!,
                            width: 1.4),
                      ),
                    ),
                    backgroundColor:
                    MaterialStateProperty.all<Color>(
                        Colors.transparent),
                  ),
                  child: SizedBox(
                    height: 40,
                    width: 120,
                    child: Center(
                      child: Text(
                        "Registrarse",
                        style: TextStyle(
                            color: Colors.deepPurple[200]!,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login(BuildContext context) async {

    FocusManager.instance.primaryFocus?.unfocus(); // Oculta el teclado
    AlertController.hide();

    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      AlertController.show(
        "Faltan credenciales",
        "Debe completar el formulario para ingresar!",
        TypeAlert.warning,
      );

      return;
    }

    widget.updateShowLoadingState(true);

    Future.delayed(const Duration(seconds: 2), () async {
      try{
        final String token = await UserService.loginUser(
            _emailController.text, _passwordController.text);
        await SecureStorage.saveToken(token);

        if (context.mounted) {
          Navigator.pushReplacementNamed(
            context,
            '/home',
          );
        }
      } catch(e) {
        AlertController.show(
          "Fallo al Ingresar",
          "Ha ocurrido un error iniciando sesiòn!",
          TypeAlert.error,
        );
      }

      widget.updateShowLoadingState(false);

    });
  }

}