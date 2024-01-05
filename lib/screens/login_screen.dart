import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../helpers/secure_storage_helper.dart';
import 'package:canclini_flutter_app/services/store_api/users.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:canclini_flutter_app/layouts/main_layout.dart';

import 'package:flutter_dropdown_alert/alert_controller.dart';
import 'package:flutter_dropdown_alert/model/data_alert.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {

  bool _showLoginForm = false;
  bool _showRegisterForm = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Añade un pequeño retraso para iniciar la animación
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        _showLoginForm = true;
      });
    });
  }

  void updateShowLoginFormState(bool newState){
    setState(() {
      _showLoginForm = newState;
    });
  }

  void updateShowRegisterFormState(bool newState){
    setState(() {
      _showRegisterForm = newState;
    });
  }

  void updateShowLoadingState(bool newState){
    setState(() {
      _isLoading = newState;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [
                  Colors.deepPurple[400]!,
                  Colors.deepPurple[300]!,
                  Colors.deepPurple[100]!,
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 80),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "¡ Super Store !",
                        style: GoogleFonts.pacifico(
                            color: Colors.white, fontSize: 50),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      RegisterForm(showRegisterFormState: _showRegisterForm, updateShowRegisterFormState: updateShowRegisterFormState, updateShowLoginFormState: updateShowLoginFormState,updateShowLoadingState: updateShowLoadingState),
                      LoginForm(showLoginFormState: _showLoginForm, updateShowLoginFormState: updateShowLoginFormState, updateShowRegisterFormState: updateShowRegisterFormState, updateShowLoadingState: updateShowLoadingState)
                    ],
                  )
                ),
              ],
            ),
          ),
          _isLoading
              ? Container(
                  color: Colors.black.withOpacity(0.7),
                  child: Center(
                    child: LoadingAnimationWidget.threeRotatingDots(
                      color: Colors.white,
                      size: 100,
                    ),
                  ),
                )
              : const SizedBox(), // Widget vacío cuando isLoading es falso
        ],
      ),
    );
  }

}

///
///  --------- SUB WIDGETS -------------
///

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
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MainLayout()),
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

class RegisterForm extends StatefulWidget{

  final bool showRegisterFormState;
  final Function(bool) updateShowRegisterFormState;
  final Function(bool) updateShowLoginFormState;
  final Function(bool) updateShowLoadingState;

  const RegisterForm({super.key, required this.showRegisterFormState, required this.updateShowRegisterFormState, required this.updateShowLoadingState, required this.updateShowLoginFormState});

  @override
  State createState() => _RegisterFormState();

}

class _RegisterFormState extends State<RegisterForm> {
  bool _hidePass = true;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return AnimatedContainer(
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
      transform: Matrix4.translationValues(
        0.0,
        widget.showRegisterFormState ? 0.0 : MediaQuery.of(context).size.height,
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
                          controller: _usernameController,
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              hintText: "Username",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none
                          ),
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
                              prefixIcon: Icon(Icons.alternate_email),
                              hintText: "Email",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none
                          ),
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
                              prefixIcon: const Icon(Icons.password_rounded),
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
                TextButton(
                  onPressed: () {
                    register(context);
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
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
                        "Registrarse",
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
                    widget.updateShowRegisterFormState(false);
                    Future.delayed(const Duration(milliseconds: 300), () => widget.updateShowLoginFormState(true));
                    _emailController.clear();
                    _passwordController.clear();
                    _usernameController.clear();
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
                        "Volver al inicio",
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

  void register(BuildContext context) async {

    FocusManager.instance.primaryFocus?.unfocus(); // Oculta el teclado
    AlertController.hide();

    if (_emailController.text.isEmpty || _passwordController.text.isEmpty || _usernameController.text.isEmpty) {
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
        final String token = await UserService.registerUser(
            _emailController.text, _passwordController.text);
        await SecureStorage.saveToken(token);

        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MainLayout()),
          );
        }
      } catch(e) {
        AlertController.show(
          "Fallo al Registrarse",
          "Ha ocurrido un error intentando registrar al usuario!",
          TypeAlert.error,
        );
      }

      widget.updateShowLoadingState(false);

    });
  }
}