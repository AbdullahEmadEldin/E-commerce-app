import 'package:e_commerce_app/business_logic_layer/product_cubit/product_cubit.dart';
import 'package:e_commerce_app/data_layer/repository/firestore_repo.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/Controllers/auth_controller.dart';
import 'package:e_commerce_app/data_layer/Services/firebase_auth.dart';
import 'package:e_commerce_app/view/Pages/auth_page.dart';
import 'package:e_commerce_app/view/Pages/bottom_navbar.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return StreamBuilder<User?>(
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          if (user == null) {
            return ChangeNotifierProvider<AuthController>(
                create: (_) => AuthController(auth: auth),
                child: const AuthPage());
          }
          return ChangeNotifierProvider<AuthController>(
            create: (_) => AuthController(auth: auth),
            child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) =>
                      ProductCubit(productsRepositroy: FirestoreRepo(user.uid)),
                ),
              ],
              child: const BottomNavBar(),
            ),
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
