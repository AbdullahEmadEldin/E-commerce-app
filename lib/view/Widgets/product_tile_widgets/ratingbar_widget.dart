import 'package:e_commerce_app/data_layer/Models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductRatingBar extends StatelessWidget {
  const ProductRatingBar({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      rating: product.rate?.toDouble() ?? 0,
      itemCount: product.rate ?? 0,
      itemSize: 25,
      itemBuilder: (context, rating) =>
          const Icon(Icons.star, color: Colors.amber),
    );
  }
}
