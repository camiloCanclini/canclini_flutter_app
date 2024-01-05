import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:canclini_flutter_app/screens/barrel_files/main_screens.dart' as screens;
import 'package:molten_navigationbar_flutter/molten_navigationbar_flutter.dart';

import '../common_widgets/app_bar.dart';
import '../common_widgets/drawer_menu.dart';

class MainLayout extends StatefulWidget {

  const MainLayout({super.key});

  @override
  State<StatefulWidget> createState() => MainLayoutState();

}

class MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 1;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.deepPurple[600]!, Colors.white!],
          stops: [0.25, 0.75],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          children: <Widget>[
            screens.ProductsScreen(),
            screens.HomeScreen(),
            screens.UserProfileScreen()
          ],
        ),
        bottomNavigationBar:  MoltenBottomNavigationBar(
          selectedIndex: _selectedIndex,
          barColor: Colors.deepPurple,
          curve: Curves.easeInSine,
          duration: const Duration(milliseconds: 300),
          domeHeight: 15,
          onTabChange: _onItemTapped,
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
      ),
    );
  }
}

