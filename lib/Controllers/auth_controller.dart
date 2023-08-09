import 'package:e_commerce_app/Services/auth.dart';
import 'package:e_commerce_app/Utilities/enums.dart';
import 'package:flutter/material.dart';

class AuthController with ChangeNotifier {
  final AuthBase auth;
  String email;
  String password;
  AuthFormType authFormType;

  AuthController(
      {required this.auth,
      this.email = '',
      this.password = '',
      this.authFormType = AuthFormType.login});

  void copyWith({
    String? email,
    String? password,
    AuthFormType? authFormType,
  }) {
    this.email = email ?? this.email;
    this.password = password ?? this.password;
    this.authFormType = authFormType ?? this.authFormType;
    notifyListeners();
  }

  void updateEmail(String email) => copyWith(email: email);
  void updatePassword(String password) => copyWith(password: password);

  void toggleFormType() {
    final formType = authFormType == AuthFormType.login
        ? AuthFormType.register
        : AuthFormType.login;
    copyWith(email: '', password: '', authFormType: formType);
  }

  Future<void> submit() async {
    try {
      if (authFormType == AuthFormType.login) {
        await auth.loginWithEmailAndPassword(email, password);
      } else {
        await auth.signUpWithEmailAndPassword(email, password);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logOut() async {
    try {
      await auth.logOut();
    } catch (e) {
      debugPrint('logout error: $e');
    }
  }
}
