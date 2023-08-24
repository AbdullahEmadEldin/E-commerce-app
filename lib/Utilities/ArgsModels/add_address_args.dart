import '../../Controllers/database_controller.dart';
import '../../Models/address_model.dart';

class AddShippingAddressArgs {
  final Database database;
  final ShippingAddress? shippingAddress;

  AddShippingAddressArgs({required this.database, this.shippingAddress});
}
