import 'package:e_commerce_app/Utilities/assets.dart';
import 'package:e_commerce_app/Views/Widgets/CheckoutWidgets/address_tile.dart';
import 'package:e_commerce_app/Views/Widgets/CheckoutWidgets/payment_tile.dart';
import 'package:e_commerce_app/Views/Widgets/main_button.dart';
import 'package:e_commerce_app/Views/Widgets/two_separateditems_row.dart';
import 'package:flutter/material.dart';

import '../Widgets/CheckoutWidgets/delivery_options_tile.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Shipping address',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const AddressTile(),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Payment',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                      onTap: () {},
                      child: Text(
                        'change',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: Colors.red),
                      ))
                ],
              ),
              const SizedBox(height: 16),
              const PaymentTile(),
              const SizedBox(height: 32),
              Text(
                'Delivery options',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  DeliveryOptionsTile(
                    imageSrc: AppAssets.fedExLogo,
                    daysForDelivery: '2-3',
                  ),
                  const SizedBox(width: 16),
                  DeliveryOptionsTile(
                      imageSrc: AppAssets.dhlLogo, daysForDelivery: '2-3')
                ],
              ),
              const SizedBox(height: 16),
              const TitleAndValueRow(title: 'Order: ', value: '150\$'),
              const SizedBox(height: 8),
              const TitleAndValueRow(title: 'Delivery: ', value: '15\$'),
              const SizedBox(height: 8),
              const TitleAndValueRow(title: 'Total: ', value: '165\$'),
              const SizedBox(height: 16),
              MainButton(
                text: 'Submit order',
                ontap: () {},
                hasCircularBorder: true,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
