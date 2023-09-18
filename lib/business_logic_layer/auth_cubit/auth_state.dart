part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class SuccessfulAuth extends AuthState {}

final class FailureAuth extends AuthState {
  final String? errorMsg;
  FailureAuth({this.errorMsg});
}

final class LogOut extends AuthState {}

final class FailureLogOut extends AuthState {}

final class FormTypeToggled extends AuthState {
  final AuthFormType formType;
  FormTypeToggled({required this.formType});
}
