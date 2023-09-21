import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/Utilities/constants.dart';
import 'package:e_commerce_app/data_layer/Models/product.dart';
import 'package:e_commerce_app/data_layer/Models/user_product.dart';
import 'package:e_commerce_app/data_layer/repository/firestore_repo.dart';
import 'package:meta/meta.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final Repository cartRepository;
  StreamSubscription<List<UserProduct>>? cartStreamSubscription;
  CartCubit({required this.cartRepository}) : super(CartInitial());

  Future<void> addToCart(Product product, String? dropdownValue) async {
    try {
      final userProduct = UserProduct(
          id: kIdFromDartGenerator(),
          color: 'color',
          size: dropdownValue ?? 'size',
          productID: product.productID,
          title: product.title,
          price: product.price,
          imgUrl: product.imgUrl);
      await cartRepository.addToCart(userProduct);
      print('Sucessssssss added to cart');
      emit(SucessAddToCart());
    } catch (e) {
      print('errorrrrrrrrrrrrr add product to cart: ${e.toString()}');
      emit(FailureAddToCart(errorMsg: e.toString()));
    }
  }

  Future<void> getCartProducts() async {
    emit(LoadingCartProducts());
    cartStreamSubscription = cartRepository.myBag().listen((cartProducts) {
      print('Geeeeeeeeeeeeeeeeet Cart products doneeee');
      emit(SuccessCartProducts(cartProducts: cartProducts));
    }, onError: (error) {
      print('erorrrrrrrrr getttting cart products');
      emit(FailureCartProducts(errorMsg: error.toString()));
      close();
    });
  }

  @override
  Future<void> close() {
    cartStreamSubscription?.cancel();
    return super.close();
  }
}
