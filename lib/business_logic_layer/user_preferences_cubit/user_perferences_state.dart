part of 'user_perferences_cubit.dart';

@immutable
abstract class UserPrefState {}

final class UserPrefInitial extends UserPrefState {}

///Shipping Addresses states
final class ShippingAddressesLoading extends UserPrefState {}

final class ShippingAddressesSucess extends UserPrefState {
  final List<ShippingAddress> shippingAddress;

  ShippingAddressesSucess({required this.shippingAddress});
}

final class ShippingAddressesFailure extends UserPrefState {
  final String errorMsg;
  ShippingAddressesFailure({required this.errorMsg});
}

///Default shipping address
final class DefaultShippingAddressLoading extends UserPrefState {}

final class DefaultShippingAddressSucess extends UserPrefState {
  final List<ShippingAddress>? shippingAddress;
  DefaultShippingAddressSucess({this.shippingAddress});
}

final class DefaultShippingAddressFailure extends UserPrefState {
  final String? errorMsg;
  DefaultShippingAddressFailure({this.errorMsg});
}

///Save address states

final class SaveAddressSucess extends UserPrefState {
  final ShippingAddress shippingAddress;
  SaveAddressSucess({required this.shippingAddress});
}

final class SaveAddressFailed extends UserPrefState {
  final String? errorMsg;
  SaveAddressFailed({this.errorMsg});
}

///Delivery Options states
final class DelvieryOptionsLoading extends UserPrefState {}

final class DelvieryOptionsSucess extends UserPrefState {
  final List<DeliveryOption> deliveryOptions;
  DelvieryOptionsSucess({required this.deliveryOptions});
}

final class DeliveryOptionsFailure extends UserPrefState {
  final String errorMsg;
  DeliveryOptionsFailure({required this.errorMsg});
}

///Payment States:
final class PaymentLoading extends UserPrefState {}

final class PaymentSuccess extends UserPrefState {}

final class PaymentFailure extends UserPrefState {
  final String errorMsg;

  PaymentFailure({required this.errorMsg});
}

///User data fetching states
final class UserDataSucessfull extends UserPrefState {
  final UserData user;

  UserDataSucessfull({required this.user});
}

final class UserDataFailure extends UserPrefState {
  final String errorMsg;
  UserDataFailure({required this.errorMsg});
}
