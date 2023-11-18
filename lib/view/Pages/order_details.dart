import 'package:e_commerce_app/Utilities/helpers.dart';
import 'package:e_commerce_app/data_layer/Models/order.dart';
import 'package:e_commerce_app/view/Widgets/cart_product_tile.dart';
import 'package:flutter/material.dart';

class OrderDetails extends StatelessWidget {
  final Order order;
  final int orderNumber;
  const OrderDetails({Key? key, required this.order, required this.orderNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Order Details'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Order No: $orderNumber',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text(
                      order.date,
                      style: const TextStyle(color: Colors.grey),
                    )
                  ],
                ),
                SizedBox(height: size.height * 0.01),
                textRichBuilder(context,
                    text1: 'Tracking number: ', text2: order.id),
                const SizedBox(height: 8),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Items: ${order.products.length}',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const Text('Processing',
                          style: TextStyle(color: Colors.green))
                    ]),
                SizedBox(height: size.height * 0.01),
                SizedBox(
                  height: size.height * 0.6,
                  child: ListView.builder(
                      itemCount: order.products.length,
                      itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: CartProductTile(
                              product: order.products[index],
                              isInterActive: false,
                            ),
                          )),
                ),
                SizedBox(height: size.height * 0.01),
                const Divider(
                  thickness: 1,
                ),
                const Text(
                  'Order information',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                textRichBuilder(context,
                    text1: 'Shippind Address:  ', text2: order.address.address),
                const SizedBox(height: 8),
                textRichBuilder(context,
                    text1: 'Delivery:  ', text2: '2-3 days'),
                const SizedBox(height: 8),
                textRichBuilder(context,
                    text1: 'Total Price:  ', text2: '${order.totalPrice}\$'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
