// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_commerce_app/data_layer/Models/address_model.dart';
import 'package:e_commerce_app/data_layer/Models/user_product.dart';

class Order {
  final String id;
  final int totalPrice;
  final List<UserProduct> products;
  final ShippingAddress address;
  final String date;
  Order({
    required this.id,
    required this.totalPrice,
    required this.products,
    required this.address,
    required this.date,
  });
  List<Map<String, dynamic>> mappingUserProductsList() {
    List<Map<String, dynamic>> userProductsList = [];
    for (int i = 0; i < products.length; i++) {
      final productMap = products[i].toMap();
      userProductsList.add(productMap);
    }
    return userProductsList;
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({'id': id});
    result.addAll({'totalPrice': totalPrice});
    result.addAll({'products': mappingUserProductsList()});
    result.addAll({'address': address.toMap()});
    result.addAll({'date': date});

    return result;
  }

  factory Order.fromMap(Map<String, dynamic> data, String docId) {
    ///we are doing this to parse the products from JSON to UesrProducts Object again
    ///and overcome this exception: Unhandled Exception: type 'List<dynamic>' is not a subtype of type 'List<UserProduct>'
    ///and the same for ShippingAddress
    final List<dynamic> productJson = data['products'];
    final List<UserProduct> products = productJson
        .map((product) => UserProduct.fromMap(product, product['id']))
        .toList();
    final addressJson = data['address'];
    final ShippingAddress address =
        ShippingAddress.fromMap(addressJson, addressJson['id']);

    return Order(
      id: docId,
      totalPrice: data['totalPrice'] ?? 0,
      products: products,
      address: address,
      date: data['date'] ?? 'xx-xx-xxxx',
    );
  }
}
