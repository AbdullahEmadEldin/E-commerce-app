import 'package:e_commerce_app/Utilities/helpers.dart';
import 'package:e_commerce_app/Utilities/routes.dart';
import 'package:e_commerce_app/data_layer/Models/order.dart';
import 'package:flutter/material.dart';

class OrderTile extends StatelessWidget {
  final Order order;
  final int orderNumber;
  const OrderTile({Key? key, required this.order, required this.orderNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: 90,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Order No: $orderNumber',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    order.date,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              textRichBuilder(context,
                  text1: 'Tracking number: ', text2: order.id),
              textRichBuilder(context,
                  text1: 'Total Price: ', text2: '${order.totalPrice}\$'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(4),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, AppRoutes.ordersDetailsPage,
                            arguments: {
                              'order': order,
                              'orderNumber': orderNumber,
                            });
                      },
                      child: const Text('  Details  '),
                    ),
                  ),
                  const Text(
                    'Processing',
                    style: TextStyle(color: Colors.green),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
