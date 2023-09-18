import 'package:e_commerce_app/data_layer/repository/firestore_repo.dart';
import 'package:e_commerce_app/data_layer/Models/user.dart';
import 'package:e_commerce_app/data_layer/Services/firebase_auth.dart';
import 'package:e_commerce_app/Utilities/constants.dart';
import 'package:e_commerce_app/Utilities/enums.dart';
import 'package:flutter/material.dart';

class AuthController with ChangeNotifier {
  final AuthService auth;
  String email;
  String password;
  AuthFormType authFormType;
  //TODO: this part not clear and need more understanding
  final Repository database = FirestoreRepo('123');

  /// why you didn't make string, email and authFormType finals ???
  /// to enable editing on them in copywith method
  AuthController(
      {required this.auth,
      this.email = '',
      this.password = '',
      this.authFormType = AuthFormType.login});

  ///copywith method should return object of the model if you will use it outside the calss
  ///but here we will use it inside the calss only to edit on some variables without create new object
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

  ///update email and password stands for textControllers
  void updateEmail(String email) => copyWith(email: email);
  void updatePassword(String password) => copyWith(password: password);

  void toggleFormType() {
    final formType = authFormType == AuthFormType.login
        ? AuthFormType.register
        : AuthFormType.login;
    //بصفر الايميل والباسورد لما يغير من اللوجين
    copyWith(email: '', password: '', authFormType: formType);
  }

  Future<void> submit() async {
    try {
      if (authFormType == AuthFormType.login) {
        await auth.loginWithEmailAndPassword(email, password);
      } else {
        final user = await auth.signUpWithEmailAndPassword(email, password);
        await database.setUserData(UserData(
          uId: user?.uid ?? kIdFromDartGenerator(),
          email: email,
        ));
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
