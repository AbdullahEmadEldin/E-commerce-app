import 'package:e_commerce_app/Utilities/routes.dart';
import 'package:e_commerce_app/Views/Pages/auth_page.dart';
import 'package:flutter/material.dart';

import '../Views/Pages/landing_page.dart';

Route<dynamic> routeGenerator(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.authenticationPage:
      return MaterialPageRoute(builder: (_) => const AuthPage());
    case AppRoutes.landingPageRoute:
    default:
      return MaterialPageRoute(builder: (_) => const LandingPage());
  }
}
