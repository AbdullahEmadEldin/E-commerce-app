import 'package:e_commerce_app/business_logic_layer/cart_cubit/cart_cubit.dart';
import 'package:e_commerce_app/data_layer/Models/product.dart';

import 'package:e_commerce_app/view/Widgets/favourite_button.dart';
import 'package:e_commerce_app/view/Widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Widgets/drop_menu_component.dart';

class ProductDetails extends StatefulWidget {
  final Product product;
  const ProductDetails({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool isFavourite = false;
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    final cartCubit = BlocProvider.of<CartCubit>(context);
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: DropdownMenuComponent(
                      items: ['S', 'M', 'L', 'XL', 'XXL'],
                      hint: 'Size',
                      onchange: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue;
                        });
                      },
                    )),
                    const Spacer(),
                    // FavouriteButton(
                    //   isFavourite: widget.product.isFavourite,
                    // ),
                  ],
                ),
                const SizedBox(height: 16),
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
                  ontap: () {
                    cartCubit.addToCart(
                        product: widget.product, dropdownValue: dropdownValue);
                  },
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
