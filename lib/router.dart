/*
 -> Handling all the routes in our app
 -> All the possible routing are mentioned here
 -> Wr are creating this file here to just get a cleaner look in our main.dart

 -> onGenerateRoute: needs a Route<dynamic data type
*/

import 'package:amazon_clone/common/widgets/bottom_bar.dart';
import 'package:amazon_clone/features/auth/screens/auth_screen.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:amazon_clone/features/product_details/screens/product_detail_screen.dart';
import 'package:amazon_clone/features/search/screens/search_screen.dart';
import 'package:amazon_clone/models/products.dart';
import 'package:flutter/material.dart';

import 'features/admin/screens/add_product_screen.dart';
import 'features/home/screens/views/category_deals_view.dart';

Route<dynamic> genrateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen(),
      );
    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen(),
      );
    case BottomNavBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BottomNavBar(),
      );
    case AddProductScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddProductScreen(),
      );
    case CategoryDealsScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => CategoryDealsScreen(
          categoryName: category,
        ),
      );
    case SearchScreen.routeName:
      var query = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SearchScreen(
          query: query,
        ),
      );
    case ProductDetailScreen.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ProductDetailScreen(
          product: product,
        ),
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
