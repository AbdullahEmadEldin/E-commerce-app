part of 'product_cubit.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}

final class ProductsLoading extends ProductState {}

final class SuccessfullyProductsLoaded extends ProductState {
  final List<Product> saleProducts;
  final List<Product> newProducts;
  final List<Product> womenProducts;
  final List<Product> menProducts;
  final List<Product> favProducts;
  final List<UserProduct> cartProducts;
  SuccessfullyProductsLoaded({
    required this.saleProducts,
    required this.newProducts,
    required this.womenProducts,
    required this.menProducts,
    required this.favProducts,
    required this.cartProducts,
  });
}

final class ProductsFailure extends ProductState {
  final String? errorMsg;
  ProductsFailure({this.errorMsg});
}

final class FavProductAddedSuccessfully extends ProductState {}

final class FavProductAddFailure extends ProductState {
  final String errMsg;

  FavProductAddFailure({required this.errMsg});
}
