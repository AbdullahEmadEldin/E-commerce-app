class UserProduct {
  final String id;
  final String productId;
  final String title;
  final int price;
  final String imgUrl;
  final String color;
  final String size;
  final int? discount;
  int quantity;
  UserProduct({
    required this.id,
    required this.productId,
    required this.color,
    required this.size,
    required this.title,
    required this.price,
    required this.imgUrl,
    this.discount = 0,
    this.quantity = 1,
  });

  UserProduct compywith({
    String? id,
    String? productId,
    String? title,
    int? price,
    String? imgUrl,
    String? color,
    String? size,
    int? discount,
    int? quantity,
  }) {
    return UserProduct(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      color: color ?? this.color,
      size: size ?? this.size,
      title: title ?? this.title,
      price: price ?? this.price,
      imgUrl: imgUrl ?? this.imgUrl,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'productID': productId});
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
      productId: map['productID'] ?? '',
      title: map['title'] ?? '',
      price: map['price']?.toInt() ?? 0,
      quantity: map['quantity']?.toInt() ?? 0,
      imgUrl: map['imgUrl'] ?? '',
      discount: map['discount']?.toInt() ?? 0,
      color: map['color'] ?? '',
      size: map['size'] ?? '',
    );
  }
}
