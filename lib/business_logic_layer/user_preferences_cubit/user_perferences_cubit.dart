import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/data_layer/Models/address_model.dart';
import 'package:e_commerce_app/data_layer/Models/delivery_option.dart';
import 'package:e_commerce_app/data_layer/repository/firestore_repo.dart';
import 'package:meta/meta.dart';

part 'user_perferences_state.dart';

class UserPrefCubit extends Cubit<UserPrefState> {
  final Repository repository;
  StreamSubscription<List<ShippingAddress>>? allAddressStreamSubScription;
  StreamSubscription<List<ShippingAddress>>? defaultAddressStreamSubScription;
  UserPrefCubit({required this.repository}) : super(UserPrefInitial());

  Future<void> getAllAddress() async {
    emit(ShippingAddressesLoading());
    allAddressStreamSubScription =
        repository.getShippingAddresses().listen((shippingAddresses) {
      emit(ShippingAddressesSucess(shippingAddress: shippingAddresses));
    }, onError: (error) {
      print('all addressss failure : ${error.toString()}');
      emit(ShippingAddressesFailure(errorMsg: error.toString()));
    });
  }

  Future<void> getDefaultShippingAddress() async {
    emit(DefaultShippingAddressLoading());
    defaultAddressStreamSubScription =
        repository.getDefaultShippingAddress().listen((shippingAddresses) {
      print('deffffault shipppping addddddresss sucesssssss');
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

  @override
  Future<void> close() {
    allAddressStreamSubScription?.cancel();
    defaultAddressStreamSubScription?.cancel();
    print('user pref cubit is closed');
    return super.close();
  }
}
