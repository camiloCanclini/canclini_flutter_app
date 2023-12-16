import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:canclini_flutter_app/screens/user_profile_screen.dart';

import '../common_widgets/app_bar.dart';
import '../common_widgets/drawer_menu.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerMenu(),
      appBar: MyAppBar(titleAppBar: 'Home'),
      body: const Center(
        child: Text('Bienvenido!'),
      ),
    );
  }
}