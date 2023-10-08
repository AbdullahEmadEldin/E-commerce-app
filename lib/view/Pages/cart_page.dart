import 'package:e_commerce_app/Utilities/routes.dart';
import 'package:e_commerce_app/business_logic_layer/cart_cubit/cart_cubit.dart';
import 'package:e_commerce_app/data_layer/Models/user_product.dart';
import 'package:e_commerce_app/view/Widgets/bag_product_tile.dart';
import 'package:e_commerce_app/view/Widgets/main_button.dart';
import 'package:e_commerce_app/view/Widgets/two_separateditems_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int totalPrice = 0;
  List<UserProduct> cartProducts = [];

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CartCubit>(context).getCartProducts();
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'My Cart',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.search))
              ],
            ),
            const SizedBox(height: 16),
            BlocBuilder<CartCubit, CartState>(builder: (context, state) {
              if (state is SuccessCartProducts) {
                cartProducts = state.cartProducts;
                if (state is LoadingCartProducts) {
                  return const CircularProgressIndicator.adaptive();
                } else if (cartProducts.isEmpty) {
                  return const Center(child: Text('No products added to cart'));
                }

                return Expanded(
                  child: ListView.builder(
                    primary: true,
                    shrinkWrap: true,
                    itemCount: cartProducts.length,
                    itemBuilder: (_, index) {
                      return BagProductTile(product: cartProducts[index]);
                    },
                  ),
                );
              } else if (state is FailureCartProducts) {
                return Center(
                    child: Text('Error Fetching products: ${state.errorMsg}'));
              } else {
                return const Center(
                    child: Text(
                        'This is initial state which means unknown problem'));
              }
            }),
            const SizedBox(height: 16),
            BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                if (state is SuccessCartProducts) {
                  totalPrice = 0;
                  for (var product in state.cartProducts) {
                    totalPrice += product.price;
                  }
                  print('totalpriceee: $totalPrice');
                }
                return TitleAndValueRow(
                    title: 'Total price', value: '$totalPrice\$');
              },
            ),
            const SizedBox(height: 16),
            MainButton(
              text: 'Checkout',
              ontap: () {
                Navigator.of(context, rootNavigator: true).pushNamed(
                  AppRoutes.chekoutPage,
                  arguments: totalPrice,
                );
              },
              hasCircularBorder: true,
            )
          ]),
        ),
      ),
    );
  }
}
