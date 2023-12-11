import 'package:flutter/material.dart';
import 'package:canclini_flutter_app/themes/application_themes.dart';


class ThemeProvider extends ChangeNotifier{

  ThemeData theme;

  ThemeProvider({
    required bool isDarkMode
  }):theme = (isDarkMode) ? ThemeData.dark(): ThemeData.light();


  setLight(){
    theme = DefaultTheme.defaultTheme;
    notifyListeners();
  }

  setDark(){
    theme = DefaultTheme.darkTheme;
    notifyListeners();
  }

}