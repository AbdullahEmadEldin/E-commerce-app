import 'package:e_commerce_app/Utilities/routes.dart';
import 'package:e_commerce_app/Views/Pages/auth_page.dart';
import 'package:e_commerce_app/Views/Pages/bottom_navbar.dart';
import 'package:e_commerce_app/Views/Pages/profile_page.dart';
import 'package:flutter/material.dart';

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
    case AppRoutes.landingPageRoute:
    default:
      return MaterialPageRoute(
          builder: (_) => const LandingPage(), settings: settings);
  }
}
