import 'package:e_commerce_app/Utilities/assets.dart';

class Product {
  final String productID;
  final String title;
  final int price;
  final int? discount;
  final String imgUrl;
  final String category;
  final int? rate;
  Product(
      {required this.productID,
      required this.title,
      required this.price,
      this.category = 'Other',
      this.rate,
      this.discount,
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
      'imgUrl': imgUrl
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
    );
  }
}

///mock up of produtc's list
List<Product> dummyProducts = [
  Product(
      productID: '1',
      title: 'T-shirt',
      price: 300,
      category: 'Men',
      imgUrl: AppAssets.tempProduct1,
      discount: 20),
  Product(
      productID: '1',
      title: 'T-shirt',
      price: 300,
      category: 'Men',
      imgUrl: AppAssets.tempProduct1),
  Product(
      productID: '1',
      title: 'T-shirt',
      price: 300,
      category: 'Men',
      imgUrl: AppAssets.tempProduct1,
      discount: 30),
  Product(
      productID: '1',
      title: 'T-shirt',
      price: 300,
      category: 'Men',
      imgUrl: AppAssets.tempProduct1),
  Product(
      productID: '1',
      title: 'T-shirt',
      price: 300,
      category: 'Men',
      imgUrl: AppAssets.tempProduct1),
  Product(
      productID: '1',
      title: 'T-shirt',
      price: 300,
      category: 'Men',
      imgUrl: AppAssets.tempProduct1),
];
