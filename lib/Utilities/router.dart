import 'package:e_commerce_app/business_logic_layer/cart_cubit/cart_cubit.dart';
import 'package:e_commerce_app/business_logic_layer/user_preferences_cubit/user_perferences_cubit.dart';
import 'package:e_commerce_app/data_layer/Models/address_model.dart';
import 'package:e_commerce_app/data_layer/repository/firestore_repo.dart';
import 'package:e_commerce_app/data_layer/Models/product.dart';
import 'package:e_commerce_app/Utilities/routes.dart';
import 'package:e_commerce_app/view/Pages/ShippingAddresses/add_address_page.dart';
import 'package:e_commerce_app/view/Pages/ShippingAddresses/view_addresses_page.dart';
import 'package:e_commerce_app/view/Pages/auth_page.dart';
import 'package:e_commerce_app/view/Pages/bottom_navbar.dart';
import 'package:e_commerce_app/view/Pages/checkout_page.dart';
import 'package:e_commerce_app/view/Pages/credit_card_page.dart';
import 'package:e_commerce_app/view/Pages/product_details.dart';
import 'package:e_commerce_app/view/Pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      return MaterialPageRoute(
          builder: (_) => BlocProvider(
                create: (context) => CartCubit(
                    cartRepository: FirestoreRepo(LandingPage.user!.uid)),
                child: ProductDetails(product: product),
              ),
          settings: settings);
    case AppRoutes.chekoutPage:
      final totalPrice = settings.arguments as int;
      return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => UserPrefCubit(
                        repository: FirestoreRepo(LandingPage.user!.uid)),
                  ),
                  BlocProvider(
                    create: (context) => CartCubit(
                        cartRepository: FirestoreRepo(LandingPage.user!.uid)),
                  ),
                ],
                child: CheckoutPage(
                  totalPrice: totalPrice,
                ),
              ));
    case AppRoutes.addAddressPage:
      final shippingAddress = settings.arguments as ShippingAddress?;
      return MaterialPageRoute(
          builder: (_) => BlocProvider(
                create: (context) => UserPrefCubit(
                    repository: FirestoreRepo(LandingPage.user!.uid)),
                child: AddAddressPage(
                  shippingAddress: shippingAddress,
                ),
              ));
    case AppRoutes.viewAddressesPage:
      final sharedValue = settings.arguments as int;
      return MaterialPageRoute(
          builder: (_) => BlocProvider(
                create: (context) => UserPrefCubit(
                    repository: FirestoreRepo(LandingPage.user!.uid)),
                child: ViewAddressesPage(
                  sharedValue: sharedValue,
                ),
              ));
    case AppRoutes.creditCardPage:
      final totalPrice = settings.arguments as int;
      return MaterialPageRoute(
          builder: (_) => BlocProvider(
              create: (context) => UserPrefCubit(
                  repository: FirestoreRepo(LandingPage.user!.uid)),
              child: CreditCardPage(paymentPrice: totalPrice)));
    case AppRoutes.landingPageRoute:
    default:
      return MaterialPageRoute(
          builder: (_) => const LandingPage(), settings: settings);
  }
}
