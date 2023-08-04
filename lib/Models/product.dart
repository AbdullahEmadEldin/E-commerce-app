import 'package:e_commerce_app/Utilities/assets.dart';

class Product {
  final String id;
  final String title;
  final int price;
  final int? discout;
  final String imgUrl;
  final String category;
  final double? rate;
  Product(
      {required this.id,
      required this.title,
      required this.price,
      this.category = 'Other',
      this.rate,
      this.discout,
      required this.imgUrl});
}

///mock up of produtc's list
List<Product> dummyProducts = [
  Product(
      id: '1',
      title: 'T-shirt',
      price: 300,
      category: 'Men',
      imgUrl: AppAssets.tempProduct1,
      discout: -20),
  Product(
      id: '1',
      title: 'T-shirt',
      price: 300,
      category: 'Men',
      imgUrl: AppAssets.tempProduct1),
  Product(
      id: '1',
      title: 'T-shirt',
      price: 300,
      category: 'Men',
      imgUrl: AppAssets.tempProduct1,
      discout: -30),
  Product(
      id: '1',
      title: 'T-shirt',
      price: 300,
      category: 'Men',
      imgUrl: AppAssets.tempProduct1),
  Product(
      id: '1',
      title: 'T-shirt',
      price: 300,
      category: 'Men',
      imgUrl: AppAssets.tempProduct1),
  Product(
      id: '1',
      title: 'T-shirt',
      price: 300,
      category: 'Men',
      imgUrl: AppAssets.tempProduct1),
];
