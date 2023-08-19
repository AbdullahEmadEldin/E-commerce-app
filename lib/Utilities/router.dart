import 'package:e_commerce_app/Controllers/database_controller.dart';
import 'package:e_commerce_app/Models/product.dart';
import 'package:e_commerce_app/Utilities/routes.dart';
import 'package:e_commerce_app/Views/Pages/auth_page.dart';
import 'package:e_commerce_app/Views/Pages/bottom_navbar.dart';
import 'package:e_commerce_app/Views/Pages/product_details.dart';
import 'package:e_commerce_app/Views/Pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Views/Pages/landing_page.dart';

Route<dynamic> routeGenerator(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.authenticationPage:
      return MaterialPageRoute(
          builder: (_) => const AuthPage(), settings: settings);
    case AppRoutes.bottomBar:
      return MaterialPageRoute(
          builder: (_) => const BottomNavBar(), settings: settings);
    case AppRoutes.profilePageRote:
      return MaterialPageRoute(
          builder: (_) => const ProfilePage(), settings: settings);
    case AppRoutes.productDetails:
      //TODO: A massive refactor should be done in this part and it's realted files:
      //product_tile_home &&& product_details
      final args = settings.arguments as Map<String, dynamic>;
      final product = args['product'] as Product;
      final database = args['database'];
      return MaterialPageRoute(
          builder: (_) => Provider<Database>.value(
                value: database,
                child: ProductDetails(product: product),
              ),
          settings: settings);
    case AppRoutes.landingPageRoute:
    default:
      return MaterialPageRoute(
          builder: (_) => const LandingPage(), settings: settings);
  }
}
