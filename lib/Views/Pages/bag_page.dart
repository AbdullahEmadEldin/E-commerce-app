import 'package:e_commerce_app/Models/product.dart';
import 'package:e_commerce_app/Models/user_product.dart';
import 'package:e_commerce_app/Utilities/routes.dart';
import 'package:e_commerce_app/Views/Widgets/bag_product_tile.dart';
import 'package:e_commerce_app/Views/Widgets/main_button.dart';
import 'package:e_commerce_app/Views/Widgets/two_separateditems_row.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Controllers/database_controller.dart';

class BagPage extends StatefulWidget {
  const BagPage({Key? key}) : super(key: key);

  @override
  State<BagPage> createState() => _BagPageState();
}

class _BagPageState extends State<BagPage> {
  int totalPrice = 0;

//TODO: this explaination from tarek but it just rebuild one time
  ///why we just calcualte the price inside the listview ?!
  ///because it's inside a streambuilder and it rebuilds widget continously
  ///So you can't add set state inside it
  ///Another Q: why we didn't use initState ??
  ///because it recalled in the first buid only
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    final myCart =
        await Provider.of<Database>(context, listen: false).myBag().first;
    myCart.forEach((element) {
      setState(() {
        totalPrice += element.price;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final databaseProvider = Provider.of<Database>(context);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'My Bag',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.search))
              ],
            ),
            const SizedBox(height: 16),
            StreamBuilder<List<UserProduct>>(
                stream: databaseProvider.myBag(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    final cartProducts = snapshot.data;
                    if (cartProducts == null || cartProducts.isEmpty) {
                      return const Center(child: Text('No data available'));
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
                  }
                  return Center(child: CircularProgressIndicator());
                }),
            const SizedBox(height: 16),
            TitleAndValueRow(title: 'Total price', value: '$totalPrice\$'),
            const SizedBox(height: 16),
            MainButton(
              text: 'Checkout',
              ontap: () {
                Navigator.of(context, rootNavigator: true)
                    .pushNamed(AppRoutes.chekoutPage);
              },
              hasCircularBorder: true,
            )
          ]),
        ),
      ),
    );
  }
}
