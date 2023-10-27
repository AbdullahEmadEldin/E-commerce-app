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

///Fav products states
final class FavProductsLoading extends ProductState {}

final class FavProductsFetched extends ProductState {
  final List<Product> fav;

  FavProductsFetched({required this.fav});
}

final class FavProductsFailure extends ProductState {
  final String errMsg;

  FavProductsFailure({required this.errMsg});
}

final class FavProductAddedSuccessfully extends ProductState {}

final class FavProductAddFailure extends ProductState {
  final String errMsg;

  FavProductAddFailure({required this.errMsg});
}
