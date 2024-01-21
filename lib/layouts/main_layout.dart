import 'package:canclini_flutter_app/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:canclini_flutter_app/screens/barrel_files/main_screens.dart' as screens;
import 'package:molten_navigationbar_flutter/molten_navigationbar_flutter.dart';
import 'package:provider/provider.dart';

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
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: Builder(
        builder: (context) {
          ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [themeProvider.themeModel.primaryColor, themeProvider.themeModel.backgroundColor],
                stops: const [0.25, 0.75],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).padding.top),
                  Expanded(
                    child: NotificationListener<OverscrollIndicatorNotification>(
                      onNotification: (notification) {
                        notification.disallowIndicator();
                        return false;
                      },
                      child: PageView(
                        controller: _pageController,
                        physics: const BouncingScrollPhysics(),
                        onPageChanged: (index) {
                          setState(() {
                            _selectedIndex = index;
                          });
                        },
                        children: <Widget>[
                          screens.ProductsScreen(),
                          screens.HomeScreen(),
                          screens.UserProfileScreen(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: MoltenBottomNavigationBar(
                selectedIndex: _selectedIndex,
                barColor: themeProvider.themeModel.bottomBarColor,
                curve: Curves.easeInSine,
                domeCircleColor: Colors.white,
                duration: const Duration(milliseconds: 300),
                domeHeight: 15,
                onTabChange: _onItemTapped,
                tabs: [
                  MoltenTab(
                    icon: const Icon(Icons.shelves),
                    unselectedColor: Colors.white,
                    selectedColor: Colors.black,
                  ),
                  MoltenTab(
                    icon: const Icon(Icons.home),
                    unselectedColor: Colors.white,
                    selectedColor: Colors.black,
                  ),
                  MoltenTab(
                    icon: const Icon(Icons.person),
                    unselectedColor: Colors.white,
                    selectedColor: Colors.black,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

}

