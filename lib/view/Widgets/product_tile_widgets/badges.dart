import 'package:e_commerce_app/data_layer/Models/product.dart';
import 'package:flutter/material.dart';

class ProductBadge extends StatelessWidget {
  final bool isNew;
  final Product product;
  const ProductBadge({
    super.key,
    required this.product,
    required this.isNew,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 25,
        width: 40,
        decoration: BoxDecoration(
          color: isNew ? Colors.black : Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
            child: Text(
          isNew ? 'New' : "-${product.discount}%",
          style: const TextStyle(color: Colors.white),
        )),
      ),
    );
  }
}
