import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:canclini_flutter_app/screens/user_profile_screen.dart';
import 'package:molten_navigationbar_flutter/molten_navigationbar_flutter.dart';

import '../common_widgets/app_bar.dart';
import '../common_widgets/drawer_menu.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => HomeScreenState();

}

class HomeScreenState extends State<HomeScreen>{
  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:  MoltenBottomNavigationBar(
        selectedIndex: selectedIndex,
        barColor: Colors.deepPurple,
        curve: Curves.easeInSine,
        duration: const Duration(milliseconds: 300),
        domeHeight: 15,
        onTabChange: (clickedIndex) {
          setState(() {
            selectedIndex = clickedIndex;
          });
        },
        tabs: [
          MoltenTab(
            icon: const Icon(Icons.shelves),
          ),
          MoltenTab(
            icon: const Icon(Icons.home),
          ),
          MoltenTab(
            icon: const Icon(Icons.person),
          ),
        ],
      ),
      appBar: MyAppBar(titleAppBar: 'Home'),
      body: const Center(
        child: Text('Bienvenido!'),
      ),
    );
  }

}