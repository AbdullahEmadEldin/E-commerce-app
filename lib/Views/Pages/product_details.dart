import 'package:e_commerce_app/Controllers/database_controller.dart';
import 'package:e_commerce_app/Models/product.dart';
import 'package:e_commerce_app/Models/user_product.dart';
import 'package:e_commerce_app/Utilities/constants.dart';
import 'package:e_commerce_app/Views/Widgets/dialog.dart';
import 'package:e_commerce_app/Views/Widgets/favourite_button.dart';
import 'package:e_commerce_app/Views/Widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Widgets/drop_menu_component.dart';

class ProductDetails extends StatefulWidget {
  final Product product;
  const ProductDetails({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool isFavourite = false;
  late String? dropdownValue;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final database = Provider.of<Database>(context);
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
                    Spacer(),
                    FavouriteButton(),
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
                  ontap: () => _addToCart(database),
                  hasCircularBorder: true,
                )
              ],
            ),
          ),
        ],
      )),
    );
  }

  Future<void> _addToCart(Database database) async {
    final databaseController = Provider.of<Database>(context, listen: false);
    try {
      final userProduct = UserProduct(
          id: kIdFromDartGenerator(),
          color: 'color',
          size: dropdownValue ?? 'size',
          productID: widget.product.productID,
          title: widget.product.title,
          price: widget.product.price,
          imgUrl: widget.product.imgUrl);
      await databaseController.addToCart(userProduct);
    } catch (e) {
      return MainDialog(
              context: context,
              title: 'Error',
              content: 'Coldn\'t add the product to cart, Please try again')
          .showAlertDialog();
    }
  }
}
