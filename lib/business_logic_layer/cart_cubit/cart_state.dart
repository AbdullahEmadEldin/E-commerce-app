part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

final class SucessAddToCart extends CartState {}

final class FailureAddToCart extends CartState {
  final String errorMsg;
  FailureAddToCart({required this.errorMsg});
}

///
final class LoadingCartProducts extends CartState {}

final class SuccessCartProducts extends CartState {
  final List<UserProduct> cartProducts;
  SuccessCartProducts({required this.cartProducts});
}

final class FailureCartProducts extends CartState {
  final String errorMsg;
  FailureCartProducts({required this.errorMsg});
}
