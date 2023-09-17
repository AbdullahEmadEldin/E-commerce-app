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
  StreamSubscription<List<Product>>? saleStreamSubScription;
  StreamSubscription<List<Product>>? newStreamSubScription;

  ProductCubit({required this.productsRepositroy}) : super(ProductsLoading());

  void retrieveAllProducts() async {
    saleStreamSubScription =
        productsRepositroy.salesProductStream().listen((saleProducts) {
      this.saleProducts = saleProducts;
    });
    newStreamSubScription =
        productsRepositroy.newProductStream().listen((newProducts) {
      this.newProducts = newProducts;
      emit(SuccessfullyProductsLoaded(
          saleProducts: saleProducts, newProducts: newProducts));
    }, onError: (error) {
      print('error in home page products ${error.toString()}');
      emit(ProductsFailure(
          errorMsg: 'error in home page products: ${error.toString()}'));
    });
  }

  @override
  Future<void> close() {
    saleStreamSubScription?.cancel();
    newStreamSubScription?.cancel();
    return super.close();
  }
}
