import 'package:e_commerce_app/business_logic_layer/auth_cubit/auth_cubit.dart';
import 'package:e_commerce_app/business_logic_layer/cart_cubit/cart_cubit.dart';
import 'package:e_commerce_app/business_logic_layer/product_cubit/product_cubit.dart';
import 'package:e_commerce_app/business_logic_layer/user_preferences_cubit/user_perferences_cubit.dart';
import 'package:e_commerce_app/data_layer/repository/firestore_repo.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/Controllers/auth_controller.dart';
import 'package:e_commerce_app/data_layer/Services/firebase_auth.dart';
import 'package:e_commerce_app/view/Pages/auth_page.dart';
import 'package:e_commerce_app/view/Pages/bottom_navbar.dart';

class LandingPage extends StatelessWidget {
  static User? user;
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService =
        BlocProvider.of<AuthCubit>(context, listen: false).authService;
    //final auth = Provider.of<AuthService>(context, listen: false);
    return StreamBuilder<User?>(
      stream: authService.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          LandingPage.user = user;
          if (user == null) {
            return BlocProvider(
                create: (_) => AuthCubit(authService: authService),
                child: const AuthPage());
          }
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => AuthCubit(authService: authService),
              ),
              BlocProvider(
                create: (context) =>
                    ProductCubit(productsRepositroy: FirestoreRepo(user.uid)),
              ),
              BlocProvider(
                create: (context) =>
                    CartCubit(cartRepository: FirestoreRepo(user.uid)),
              ),
              BlocProvider(
                create: (context) =>
                    UserPrefCubit(repository: FirestoreRepo(user.uid)),
              ),
            ],
            child: const BottomNavBar(),
          );
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,
              color: Colors.red,
            ),
          ),
        );
      },
    );
  }
}