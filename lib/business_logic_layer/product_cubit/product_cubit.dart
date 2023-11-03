import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/data_layer/Models/product.dart';
import 'package:e_commerce_app/data_layer/repository/firestore_repo.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final Repository productsRepositroy;
  List<Product> saleProducts = [];
  List<Product> newProducts = [];
  List<Product> womenProducts = [];
  List<Product> menProducts = [];
  StreamSubscription<List<Product>>? saleStreamSubScription;
  StreamSubscription<List<Product>>? newStreamSubScription;
  StreamSubscription<List<Product>>? favStreamSubScription;
  StreamSubscription<List<Product>>? womenProductSubscription;
  StreamSubscription<List<Product>>? menProductSubscription;

  ProductCubit({required this.productsRepositroy}) : super(ProductsLoading());

  void retrieveAllProducts() async {
    womenProductSubscription =
        productsRepositroy.getWomenProducts().listen((womenProducts) {
      this.womenProducts = womenProducts;
    });
    menProductSubscription =
        productsRepositroy.getMenProducts().listen((menProducts) {
      this.menProducts = menProducts;
    });
    saleStreamSubScription =
        productsRepositroy.salesProductStream().listen((saleProducts) {
      this.saleProducts = saleProducts;
    });
    newStreamSubScription =
        productsRepositroy.newProductStream().listen((newProducts) {
      this.newProducts = newProducts;
      emit(SuccessfullyProductsLoaded(
          saleProducts: saleProducts,
          newProducts: newProducts,
          womenProducts: womenProducts,
          menProducts: menProducts));
    }, onError: (error) {
      emit(ProductsFailure(
          errorMsg: 'error in home page products: ${error.toString()}'));
    });
  }

  void addFavouriteProduct(Product product) {
    try {
      productsRepositroy.addProduct(product);
      emit(FavProductAddedSuccessfully());
    } catch (e) {
      emit(FavProductAddFailure(errMsg: e.toString()));
    }
  }

  void getFavProducts() async {
    emit(FavProductsLoading());
    favStreamSubScription =
        productsRepositroy.favouriteProducts().listen((favourites) {
      emit(FavProductsFetched(fav: favourites));
    }, onError: (error) {
      emit(FavProductsFailure(
          errMsg: 'fetching fav products error: ${error.toString()}'));
    });
  }

  Future<void> deleteProductFromFav(Product product) async {
    try {
      productsRepositroy.deleteProducts(product);
    } catch (e) {
      print('Error on deleting product from favourited::::: ${e.toString()}');
    }
  }

  @override
  Future<void> close() {
    saleStreamSubScription?.cancel();
    newStreamSubScription?.cancel();
    favStreamSubScription?.cancel();
    return super.close();
  }
}
