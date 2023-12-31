import 'package:e_commerce_app/Services/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

import 'package:e_commerce_app/Utilities/routes.dart';
import 'package:e_commerce_app/Utilities/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const EcommerceApp());
}

class EcommerceApp extends StatelessWidget {
  const EcommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<AuthBase>(
      create: (_) => Auth(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ecommerce App',
        theme: ThemeData(
            scaffoldBackgroundColor: const Color(0xffF9F9F9),
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.white,
              iconTheme: const IconThemeData(
                color: Colors.black,
              ),
              titleTextStyle: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: Colors.black),
            ),
            primarySwatch: Colors.red,
            inputDecorationTheme: InputDecorationTheme(
              fillColor: Color(0xffFFFFFF),
              labelStyle: Theme.of(context).textTheme.titleMedium,
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3.0),
                  borderSide: const BorderSide(color: Colors.grey)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  borderSide: const BorderSide(color: Colors.grey)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3.0),
                  borderSide: const BorderSide(color: Colors.red)),
            )),
        onGenerateRoute: routeGenerator,
        initialRoute: AppRoutes.landingPageRoute,
      ),
    );
  }
}
