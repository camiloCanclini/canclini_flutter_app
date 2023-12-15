import 'package:canclini_flutter_app/helpers/secure_storage_helper.dart';
import 'package:flutter/cupertino.dart';

class AuthenticationNavigator extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    checkAuth(route.navigator?.context);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    checkAuth(previousRoute?.navigator?.context);
  }

  // Función para verificar la autenticación
  void checkAuth(BuildContext? context) async {

    final bool isAuthenticated = await SecureStorage.isTokenValid();

    if (!isAuthenticated && context != null) {
      if(context.mounted){
        Navigator.pushReplacementNamed(context, 'login');
      }

    }
  }
}