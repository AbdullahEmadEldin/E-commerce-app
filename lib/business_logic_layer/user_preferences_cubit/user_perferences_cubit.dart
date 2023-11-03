import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/data_layer/Models/address_model.dart';
import 'package:e_commerce_app/data_layer/Models/delivery_option.dart';
import 'package:e_commerce_app/data_layer/Models/user.dart';
import 'package:e_commerce_app/data_layer/Services/stripe_payment/payment_service.dart';
import 'package:e_commerce_app/data_layer/repository/firestore_repo.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:meta/meta.dart';

part 'user_perferences_state.dart';

class UserPrefCubit extends Cubit<UserPrefState> {
  final Repository repository;

  StreamSubscription<List<ShippingAddress>>? allAddressStreamSubScription;
  StreamSubscription<List<ShippingAddress>>? defaultAddressStreamSubScription;
  UserPrefCubit({required this.repository}) : super(UserPrefInitial());
  String test = 'cubit wrapping test';

  List<ShippingAddress> address = [];

  Future<List<ShippingAddress>> getAllAddress() async {
    emit(ShippingAddressesLoading());

    allAddressStreamSubScription =
        repository.getShippingAddresses().listen((shippingAddresses) {
      Future.delayed(Duration.zero, () async {
        address = shippingAddresses;
      });

      emit(ShippingAddressesSucess(shippingAddress: shippingAddresses));
    }, onError: (error) {
      print('all addressss failure : ${error.toString()}');
      emit(ShippingAddressesFailure(errorMsg: error.toString()));
    });
    Future.delayed(const Duration(milliseconds: 200));
    return address;
  }

  Future<void> getDefaultShippingAddress() async {
    emit(DefaultShippingAddressLoading());
    defaultAddressStreamSubScription =
        repository.getDefaultShippingAddress().listen((shippingAddresses) {
      emit(DefaultShippingAddressSucess(shippingAddress: shippingAddresses));
    }, onError: (error) {
      print('Faaaaaauilure of default adddresss state: ${error.toString()}');
      emit(DefaultShippingAddressFailure(errorMsg: error.toString()));
    });
  }

//TODO: on hit saveAddress button there is a bad state of SaveAddressFailed how ever the address saved successfully
  Future<void> saveUserAddress(ShippingAddress shippingAddress) async {
    try {
      await repository.saveAddress(shippingAddress);
      print('saved address doneeeee');
      emit(SaveAddressSucess(shippingAddress: shippingAddress));
    } catch (e) {
      print('eeeeeeeeeeeeeeeeeeeeee: ${e.toString}');
      emit(SaveAddressFailed());
    }
  }

  Future<void> deleteAddress(ShippingAddress address) async {
    try {
      repository.deleteAddress(address);
    } catch (e) {
      print('Error on deleting address::: ${e.toString()}');
    }
  }

  Future<void> getDeliveryOptions() async {
    emit(DelvieryOptionsLoading());
    repository.deliveryOptions().first.then((delvieryOptions) {
      print('sucesssssssssssssssssssssss: delivery options');
      emit(DelvieryOptionsSucess(deliveryOptions: delvieryOptions));
    }, onError: (error) {
      print(
          'faaaaaaaiiiiiiiiiiiiiiiiiilure delivery options state: ${error.toString()}');
      emit(DeliveryOptionsFailure(errorMsg: error.toString()));
    });
  }

  Future<void> makePayment(int amount, String currency) async {
    emit(PaymentLoading());
    try {
      await PaymentService.makePayment(amount, currency);
      emit(PaymentSuccess());
    } catch (e) {
      if (e is StripeException) {
        print('paymeeeent erorrrr:  ${StripeException}');
        emit(PaymentFailure(errorMsg: e.toString()));
      } else {
        print('cubit error on payment process ${e.toString()}');
      }
    }
  }

  Future<void> getUserData() async {
    try {
      repository.getUserData().then((value) {
        emit(UserDataSucessfull(user: value));
      });
    } catch (e) {
      print('Erorr fetching Uesr dataa :::: ${e.toString()}');
      emit(UserDataFailure(errorMsg: e.toString()));
    }
  }

  @override
  Future<void> close() {
    allAddressStreamSubScription?.cancel();
    defaultAddressStreamSubScription?.cancel();
    print('user pref cubit is closed');
    return super.close();
  }
}
