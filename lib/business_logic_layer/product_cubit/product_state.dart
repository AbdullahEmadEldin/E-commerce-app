part of 'product_cubit.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}

final class ProductsLoading extends ProductState {}

final class SuccessfullyProductsLoaded extends ProductState {
  final List<Product> saleProducts;
  final List<Product> newProducts;

  SuccessfullyProductsLoaded(
      {required this.saleProducts, required this.newProducts});
}

final class ProductsFailure extends ProductState {
  final String? errorMsg;
  ProductsFailure({this.errorMsg});
}
