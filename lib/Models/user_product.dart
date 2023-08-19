import 'package:e_commerce_app/Models/product.dart';

class UserProduct extends Product {
  final String id;
  final String color;
  final String size;
  final int quantity;
  UserProduct({
    required this.id,
    required this.color,
    required this.size,
    required super.productID,
    required super.title,
    required super.price,
    required super.imgUrl,
    super.discount = 0,
    this.quantity = 1,
  });
  @override
  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'productID': productID});
    result.addAll({'title': title});
    result.addAll({'price': price});
    result.addAll({'quantity': quantity});
    result.addAll({'imgUrl': imgUrl});
    result.addAll({'discount': discount});
    result.addAll({'color': color});
    result.addAll({'size': size});

    return result;
  }

  factory UserProduct.fromMap(Map<String, dynamic> map, String documentId) {
    return UserProduct(
      id: documentId,
      title: map['title'] ?? '',
      productID: map['productID'] ?? '',
      price: map['price']?.toInt() ?? 0,
      quantity: map['quantity']?.toInt() ?? 0,
      imgUrl: map['imgUrl'] ?? '',
      discount: map['discount']?.toInt() ?? 0,
      color: map['color'] ?? '',
      size: map['size'] ?? '',
    );
  }
}
