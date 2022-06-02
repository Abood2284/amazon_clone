/*
 -> Handling all the routes in our app
 -> All the possible routing are mentioned here
 -> Wr are creating this file here to just get a cleaner look in our main.dart

 -> onGenerateRoute: needs a Route<dynamic data type
*/

import 'package:amazon_clone/features/auth/screens/auth_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> genrateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen(),
      );
    default:
      // Return your own error 404 screen.
      // TODO: Design your own error 404 screen
      return MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Error 404'),
          ),
        ),
      );
  }
}
