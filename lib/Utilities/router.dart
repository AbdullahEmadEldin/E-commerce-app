import 'package:e_commerce_app/data_layer/repository/firestore_repo.dart';
import 'package:e_commerce_app/data_layer/Models/product.dart';
import 'package:e_commerce_app/Utilities/routes.dart';
import 'package:e_commerce_app/view/Pages/ShippingAddresses/add_address_page.dart';
import 'package:e_commerce_app/view/Pages/ShippingAddresses/view_addresses_page.dart';
import 'package:e_commerce_app/view/Pages/auth_page.dart';
import 'package:e_commerce_app/view/Pages/bottom_navbar.dart';
import 'package:e_commerce_app/view/Pages/checkout_page.dart';
import 'package:e_commerce_app/view/Pages/product_details.dart';
import 'package:e_commerce_app/view/Pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view/Pages/landing_page.dart';
import 'ArgsModels/add_address_args.dart';

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
      final product = settings.arguments as Product;
      //final repository = args['repo'];
      return MaterialPageRoute(
          builder: (_) => ProductDetails(product: product), settings: settings);
    case AppRoutes.chekoutPage:
      final database = settings.arguments as Repository;
      return MaterialPageRoute(
          builder: (_) => Provider<Repository>.value(
              value: database, child: CheckoutPage()));
    case AppRoutes.addAddressPage:
      final args = settings.arguments as AddShippingAddressArgs;
      final database = args.database;
      final shippingAddress = args.shippingAddress;
      return MaterialPageRoute(
          builder: (_) => Provider<Repository>.value(
              value: database,
              child: AddAddressPage(
                shippingAddress: shippingAddress,
              )));
    case AppRoutes.viewAddressesPage:
      final database = settings.arguments as Repository;
      return MaterialPageRoute(
          builder: (_) => Provider<Repository>.value(
              value: database, child: ViewAddressesPage()));
    case AppRoutes.landingPageRoute:
    default:
      return MaterialPageRoute(
          builder: (_) => const LandingPage(), settings: settings);
  }
}
