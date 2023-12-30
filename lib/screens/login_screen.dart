import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../helpers/secure_storage_helper.dart';
import 'package:canclini_flutter_app/services/store_api/users.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'home_screen.dart';

import 'package:flutter_dropdown_alert/alert_controller.dart';
import 'package:flutter_dropdown_alert/model/data_alert.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {

  bool _showLoginForm = false;
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
                LoginForm(showLoginFormState: _showLoginForm, updateShowLoginFormState: updateShowLoginFormState, updateShowLoadingState: updateShowLoadingState)
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



  void register(BuildContext context) async {
    try {
      //final String token = await UserService.registerUser(_emailController.text, _passwordController.text);
      //await SecureStorage.saveToken(token);
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    } catch (e) {
      if (context.mounted) {
        showDialog<void>(
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

///
///  --------- SUB WIDGETS -------------
///

class LoginForm extends StatelessWidget{

  final bool showLoginFormState;
  final Function(bool) updateShowLoginFormState;
  final Function(bool) updateShowLoadingState;

  LoginForm({super.key, required this.showLoginFormState, required this.updateShowLoginFormState, required this.updateShowLoadingState});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {


    return  Expanded(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeInOut,
        transform: Matrix4.translationValues(
          0.0,
          showLoginFormState ? 0.0 : MediaQuery.of(context).size.height,
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
                            decoration: const InputDecoration(
                                hintText: "Password",
                                hintStyle:
                                TextStyle(color: Colors.grey),
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
                      // Acción al presionar el botón
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

    updateShowLoadingState(true);

    Future.delayed(const Duration(seconds: 2), () async {
      try{
        final String token = await UserService.loginUser(
            _emailController.text, _passwordController.text);
        await SecureStorage.saveToken(token);

        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        }
      } catch(e) {
        AlertController.show(
          "Fallo al Ingresar",
          "Ha ocurrido un error iniciando sesiòn!",
          TypeAlert.error,
        );
      }

      updateShowLoadingState(false);

    });
  }

}

