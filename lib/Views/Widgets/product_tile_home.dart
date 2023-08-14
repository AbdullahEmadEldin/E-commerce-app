import 'package:e_commerce_app/Models/product.dart';
import 'package:flutter/material.dart';

class ProductTileHome extends StatelessWidget {
  final Product product;
  const ProductTileHome({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  product.imgUrl,
                  fit: BoxFit.cover,
                  height: 200,
                  width: 200,
                ),
              ),
              product.discount != null ? _discountContainer() : SizedBox(),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(
            '${product.category}',
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: Color.fromARGB(255, 117, 117, 117)),
          ),
          const SizedBox(height: 4.0),
          Text(
            '${product.title}',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 4.0),
          Text.rich(TextSpan(children: [
            TextSpan(
              text: '${product.price}\$',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: const Color.fromARGB(255, 110, 110, 110),
                  decoration: product.discount != null
                      ? TextDecoration.lineThrough
                      : null),
            ),
            product.discount != null
                ? TextSpan(
                    text:
                        '  ${product.price - (product.price * (product.discount ?? 0)) / 100}\$',
                    style: const TextStyle(color: Colors.red))
                : const TextSpan(),
          ]))
        ],
      ),
    );
  }

  Widget _discountContainer() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 25,
        width: 40,
        decoration: BoxDecoration(
            color: Colors.red, borderRadius: BorderRadius.circular(20)),
        child: Center(
            child: Text(
          "-${product.discount}%",
          style: TextStyle(color: Colors.white),
        )),
      ),
    );
  }
}
