import 'package:e_commerce_app/data_layer/Models/user_product.dart';
import 'package:flutter/material.dart';

class BagProductTile extends StatelessWidget {
  final UserProduct product;
  const BagProductTile({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12)),
              child: Image.network(
                product.imgUrl,
                fit: BoxFit.cover,
                width: 120,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Colors.black),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _textRichHelper(context, 'Color', product.color),
                        const SizedBox(width: 16),
                        _textRichHelper(context, 'Size', product.size),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.more_vert),
                  Text('${product.price}\$'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _textRichHelper(BuildContext context, String text1, String text2) {
    return Text.rich(TextSpan(children: [
      TextSpan(
          text: '$text1: ',
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Colors.grey,
              )),
      TextSpan(
        text: text2,
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Colors.black,
            ),
      )
    ]));
  }
}
