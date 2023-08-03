import 'package:e_commerce_app/Utilities/router.dart';
import 'package:e_commerce_app/Utilities/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const EcommerceApp());
}

class EcommerceApp extends StatelessWidget {
  const EcommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ecommerce App',
      theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xffF9F9F9),
          primarySwatch: Colors.red,
          inputDecorationTheme: InputDecorationTheme(
              fillColor: Color(0xffFFFFFF),
              labelStyle: Theme.of(context).textTheme.titleMedium,
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3.0),
                  borderSide: const BorderSide(color: Colors.grey)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3.0),
                  borderSide: const BorderSide(color: Colors.grey)))),
      onGenerateRoute: routeGenerator,
      initialRoute: AppRoutes.authenticationPage,
    );
  }
}
