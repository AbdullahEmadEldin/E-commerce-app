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

  List<UserProduct> cartProducts = [];
  Future<void> addToCart(
      {required Product product, String? dropdownValue}) async {
    try {
      UserProduct? userProduct;
      cartProducts = await cartRepository.myCart().first;
      if (cartProducts.isEmpty) {
        userProduct = UserProduct(
          id: kIdFromDartGenerator(),
          productId: product.productID,
          color: 'color',
          size: dropdownValue ?? 'size',
          title: product.title,
          price: product.price,
          imgUrl: product.imgUrl,
          discount: product.discount,
        );
        print('000000000000000000000000000=====>>>${product.discount}');
        await cartRepository.addToCart(userProduct);
      } else {
        int index = -1;
        for (int i = 0; i < cartProducts.length; i++) {
          print(
              'boool:stored productId: ${cartProducts[i].productId}  new one:  ${product.productID}');
          if (cartProducts[i].productId == product.productID) {
            index = i;
          }
          if (index != -1) {
            await cartRepository.addToCart(cartProducts[i]
                .compywith(quantity: cartProducts[i].quantity + 1));
            print('second case');
            break;
          } else if (index == -1 && i == cartProducts.length - 1) {
            userProduct = UserProduct(
              id: kIdFromDartGenerator(),
              productId: product.productID,
              color: 'color',
              size: dropdownValue ?? 'size',
              title: product.title,
              price: product.price,
              imgUrl: product.imgUrl,
              discount: product.discount,
            );
            await cartRepository.addToCart(userProduct);
            print('000000000000000000000000000=====>>>${product.discount}');
            print('third case');
          }
        }
      }
      print('${cartProducts.length}');
      print('Sucessssssss added to cart');
      emit(SucessAddToCart());
    } catch (e) {
      print('errorrrrrrrrrrrrr add product to cart: ${e.toString()}');
      emit(FailureAddToCart(errorMsg: e.toString()));
    }
  }

  Future<void> deleteFromCart(UserProduct product) async {
    try {
      cartRepository.deleteCartProduct(userProduct: product);
    } catch (e) {
      print('error on deleting cart product:: ${e.toString}');
    }
  }

  Future<void> cartProductQuantity(
      {required UserProduct userProduct, required int quantity}) async {
    try {
      cartRepository.addToCart(userProduct.compywith(quantity: quantity));
    } catch (e) {
      print('error on modifying quantity');
    }
  }

  Future<void> getCartProducts() async {
    emit(LoadingCartProducts());
    cartStreamSubscription = cartRepository.myCart().listen((cartProducts) {
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
