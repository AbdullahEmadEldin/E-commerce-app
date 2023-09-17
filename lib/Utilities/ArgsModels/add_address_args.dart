import '../../data_layer/repository/firestore_repo.dart';
import '../../data_layer/Models/address_model.dart';

class AddShippingAddressArgs {
  final Repository database;
  final ShippingAddress? shippingAddress;

  AddShippingAddressArgs({required this.database, this.shippingAddress});
}
