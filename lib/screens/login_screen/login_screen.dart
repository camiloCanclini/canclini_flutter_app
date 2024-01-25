import 'package:SuperStore/screens/login_screen/widgets/login.dart';
import 'package:SuperStore/screens/login_screen/widgets/register.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

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


