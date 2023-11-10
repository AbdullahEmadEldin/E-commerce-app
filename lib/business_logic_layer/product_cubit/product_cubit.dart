import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/data_layer/Models/product.dart';
import 'package:e_commerce_app/data_layer/Models/user_product.dart';
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
  List<Product> favProducts = [];
  List<UserProduct> cartProducts = [];
  StreamSubscription<List<Product>>? saleStreamSubScription;
  StreamSubscription<List<Product>>? newStreamSubScription;
  StreamSubscription<List<Product>>? favStreamSubScription;
  StreamSubscription<List<Product>>? womenProductSubscription;
  StreamSubscription<List<Product>>? menProductSubscription;
  StreamSubscription<List<UserProduct>>? cartProductsSubscription;

  ProductCubit({required this.productsRepositroy}) : super(ProductsLoading());

  //! why repeating emit state???
  //to re emit the state with the new data change in real time
  //without hot reload or restart the app
  //it's a temporary solution
  //the problem is the orginal emit in home product .listen() method and it doesn't change
  //solution may be in Equatable package
  //OR finding some way to re-emit state when any list length changes
  void retrieveAllProducts() async {
    womenProductSubscription =
        productsRepositroy.getWomenProducts().listen((womenProducts) {
      this.womenProducts = womenProducts;
    });
    menProductSubscription =
        productsRepositroy.getMenProducts().listen((menProducts) {
      this.menProducts = menProducts;
    });
    favStreamSubScription =
        productsRepositroy.favouriteProducts().listen((favProducts) {
      this.favProducts = favProducts;
      emit(SuccessfullyProductsLoaded(
        saleProducts: saleProducts,
        newProducts: newProducts,
        womenProducts: womenProducts,
        menProducts: menProducts,
        favProducts: favProducts,
        cartProducts: cartProducts,
      ));
    });
    cartProductsSubscription =
        productsRepositroy.myCart().listen((cartProducts) {
      this.cartProducts = cartProducts;
      emit(SuccessfullyProductsLoaded(
        saleProducts: saleProducts,
        newProducts: newProducts,
        womenProducts: womenProducts,
        menProducts: menProducts,
        favProducts: favProducts,
        cartProducts: cartProducts,
      ));
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
        menProducts: menProducts,
        favProducts: favProducts,
        cartProducts: cartProducts,
      ));
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
    womenProductSubscription?.cancel();
    menProductSubscription?.cancel();
    cartProductsSubscription?.cancel();
    return super.close();
  }
}
