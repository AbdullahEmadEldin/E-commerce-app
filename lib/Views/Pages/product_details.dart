import 'package:e_commerce_app/Models/product.dart';
import 'package:e_commerce_app/Views/Widgets/favourite_button.dart';
import 'package:e_commerce_app/Views/Widgets/main_button.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  final Product product;

  const ProductDetails({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool isFavourite = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.title),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {}, icon: Icon(Icons.share, color: Colors.black))
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Image.network(
            widget.product.imgUrl,
            height: size.height * 0.5,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 24),
          const FavouriteButton(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.product.title,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(
                              color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    Text('\$${widget.product.price}',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold))
                  ],
                ),
                Text(
                  widget.product.category,
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(color: Colors.black45),
                ),
                const SizedBox(height: 16),
                Text(
                    'This a mock up description for this piece of clothes will customaized later, we are trying to make this text bigger in size to try responsiveness of the button position',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: Colors.black54)),
                const SizedBox(height: 16),
                MainButton(
                  text: 'Add to cart',
                  ontap: () {},
                  hasCircularBorder: true,
                )
              ],
            ),
          ),
        ],
      )),
    );
  }
}
