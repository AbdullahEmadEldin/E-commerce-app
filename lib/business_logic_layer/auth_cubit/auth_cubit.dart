import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/Utilities/constants.dart';
import 'package:e_commerce_app/Utilities/enums.dart';
import 'package:e_commerce_app/data_layer/Models/user.dart';
import 'package:e_commerce_app/data_layer/Services/firebase_auth.dart';
import 'package:e_commerce_app/data_layer/repository/firestore_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  /// the uId isn't used in this class and it will be complex to inject it
  /// so we did tight coupling here and it become internal attribute
  final Repository repo = FirestoreRepo('0000');
  final AuthService authService;
  String email;
  String password;
  String name;
  AuthFormType authFormType;
  AuthCubit(
      {required this.authService,
      this.email = '',
      this.password = '',
      this.name = '',
      this.authFormType = AuthFormType.login})
      : super(AuthInitial());

  ///copywith method should return object of the model if you will use it outside the calss
  ///but here we will use it inside the calss only to edit on some variables without create new object
  void copyWith({
    String? email,
    String? password,
    String? name,
    AuthFormType? authFormType,
  }) {
    this.email = email ?? this.email;
    this.password = password ?? this.password;
    this.name = name ?? this.name;
    this.authFormType = authFormType ?? this.authFormType;
  }

  ///update email and password stands for textControllers
  void updateEmail(String email) => copyWith(email: email);
  void updateName(String name) => copyWith(name: name);
  void updatePassword(String password) => copyWith(password: password);

  void toggleFormType() {
    final formType = authFormType == AuthFormType.login
        ? AuthFormType.register
        : AuthFormType.login;
    //بصفر الايميل والباسورد لما يغير من اللوجين
    copyWith(email: '', password: '', authFormType: formType);
    emit(FormTypeToggled(formType: formType));
  }

  Future<void> submit() async {
    emit(AuthLoading());
    try {
      if (authFormType == AuthFormType.login) {
        await authService.loginWithEmailAndPassword(email, password);
      } else {
        final user =
            await authService.signUpWithEmailAndPassword(email, password);
        await repo.setUserData(UserData(
          uId: user?.uid ?? kIdDartAutoGenerator(),
          email: email,
          name: name,
        ));
      }
      print('Login/Register sucessss');
      emit(SuccessfulAuth());
    } on FirebaseAuthException catch (e) {
      print('authentication errorr :${e.code}');
      if (e.code == 'auth/email-already-exists	') {
        emit(FailureAuth(errorMsg: 'email you entered already exists'));
      } else if (e.code == 'auth/invalid-email	') {
        emit(FailureAuth(errorMsg: 'email you entered is invalid'));
      } else if (e.code == 'user-not-found') {
        emit(FailureAuth(
            errorMsg: 'User not found \nPlease create a new email'));
      } else if (e.code == 'wrong-password') {
        emit(FailureAuth(errorMsg: 'Wrong password'));
      } else if (e.code == 'email-already-in-use') {
        emit(FailureAuth(
            errorMsg: 'Email you entered is already in use \nPlease Login'));
      }
    }
  }

  Future<void> logOut() async {
    try {
      await authService.logOut();
      emit(LogOut());
    } catch (e) {
      print('logout error: $e');
    }
  }

  Future<void> signInwithGoogle() async {
    try {
      final userCredential = await authService.signInWithGoogle();
      if (userCredential == null) {
        return;
      }
      await repo.setUserData(UserData(
        uId: userCredential.user?.uid ?? kIdDartAutoGenerator(),
        email: userCredential.user?.email ?? 'email',
        name: userCredential.user?.displayName ?? 'name',
      ));
    } catch (e) {
      print('erorr on sign in with gooooogle ${e.toString()}');
    }
  }

  Future<void> googleSignOut() async {
    try {
      await authService.googleSignOut();
    } catch (e) {
      print('Error on sign out with google ${e.toString()}');
    }
  }

  Future<void> signInWithFacebook() async {
    try {
      await authService.signInWithFacebook();
    } catch (e) {
      print('error on sign in with facebook ${e.toString()}');
    }
  }
}
