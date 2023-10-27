class Product {
  final String productID;
  final String title;
  final int price;
  final int? discount;
  final String imgUrl;
  final String category;
  bool isFavourite;
  final int? rate;

  Product(
      {required this.productID,
      required this.title,
      required this.price,
      this.category = 'Other',
      this.rate,
      this.discount,
      this.isFavourite = false,
      required this.imgUrl});

  ///both functions need more declration
  Map<String, dynamic> toMap() {
    return {
      'id': productID,
      'title': title,
      'price': price,
      'category': category,
      'rate': rate,
      'discount': discount,
      'imgUrl': imgUrl,
      'isFavourite': isFavourite,
    };
  }

  factory Product.formMap(Map<String, dynamic> map, String docId) {
    return Product(
      productID: docId,
      title: map['title'] as String,
      price: map['price'] as int,
      category: map['category'] as String,
      rate: map['rate'] as int,
      discount: map['discount'] as int,
      imgUrl: map['imgUrl'] as String,
      isFavourite: map['isFavourite'] as bool,
    );
  }
  Product compywith({
    String? productID,
    String? title,
    int? price,
    int? discount,
    String? imgUrl,
    String? category,
    bool? isFavourite,
    int? rate,
  }) {
    return Product(
      productID: productID ?? this.productID,
      title: title ?? this.title,
      price: price ?? this.price,
      imgUrl: imgUrl ?? this.imgUrl,
      discount: discount ?? this.discount,
      isFavourite: isFavourite ?? this.isFavourite,
      rate: rate ?? this.rate,
      category: category ?? this.category,
    );
  }
}
