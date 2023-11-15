import 'package:e_commerce_app/business_logic_layer/cart_cubit/cart_cubit.dart';
import 'package:e_commerce_app/data_layer/Models/user_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartProductTile extends StatefulWidget {
  final UserProduct product;
  final bool isInterActive;
  const CartProductTile(
      {Key? key, required this.product, this.isInterActive = true})
      : super(key: key);

  @override
  State<CartProductTile> createState() => _CartProductTileState();
}

class _CartProductTileState extends State<CartProductTile> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 121,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12)),
              child: Image.network(
                widget.product.imgUrl,
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
                      widget.product.title,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Colors.black),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _textRichHelper(context, 'Color', widget.product.color),
                        const SizedBox(width: 16),
                        _textRichHelper(context, 'Size', widget.product.size),
                      ],
                    ),
                    widget.isInterActive
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    BlocProvider.of<CartCubit>(context)
                                        .cartProductQuantity(
                                            userProduct: widget.product,
                                            quantity:
                                                widget.product.quantity - 1);
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: const CircleBorder(),
                                    minimumSize: Size.zero),
                                child: const Icon(Icons.remove),
                              ),
                              Text(widget.product.quantity.toString()),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    BlocProvider.of<CartCubit>(context)
                                        .cartProductQuantity(
                                            userProduct: widget.product,
                                            quantity:
                                                widget.product.quantity + 1);
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: const CircleBorder(),
                                    minimumSize: Size.zero),
                                child: const Icon(Icons.add),
                              )
                            ],
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widget.isInterActive
                      ? IconButton(
                          onPressed: () {
                            BlocProvider.of<CartCubit>(context)
                                .deleteFromCart(widget.product);
                          },
                          icon: const Icon(Icons.delete))
                      : const SizedBox(),
                  Text(
                      '${widget.product.price - (widget.product.price * (widget.product.discount ?? 0)) / 100}\$'),
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
