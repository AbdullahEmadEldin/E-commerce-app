import 'package:e_commerce_app/Controllers/database_controller.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'package:e_commerce_app/Controllers/auth_controller.dart';
import 'package:e_commerce_app/Services/firebase_auth.dart';
import 'package:e_commerce_app/Views/Pages/auth_page.dart';
import 'package:e_commerce_app/Views/Pages/bottom_navbar.dart';

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
              child: Provider<Database>(
                  create: (_) => FirestoreDatabase(
                      user.uid), //user.uid is built attribute of firebase
                  child: const BottomNavBar()));
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
