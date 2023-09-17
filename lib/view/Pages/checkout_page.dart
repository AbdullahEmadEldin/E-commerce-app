import 'package:e_commerce_app/data_layer/repository/firestore_repo.dart';
import 'package:e_commerce_app/data_layer/Models/address_model.dart';
import 'package:e_commerce_app/data_layer/Models/delivery_option.dart';
import 'package:e_commerce_app/Utilities/routes.dart';
import 'package:e_commerce_app/view/Widgets/CheckoutWidgets/add_address_button.dart';
import 'package:e_commerce_app/view/Widgets/CheckoutWidgets/address_tile.dart';
import 'package:e_commerce_app/view/Widgets/CheckoutWidgets/payment_tile.dart';
import 'package:e_commerce_app/view/Widgets/main_button.dart';
import 'package:e_commerce_app/view/Widgets/two_separateditems_row.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Widgets/CheckoutWidgets/delivery_options_tile.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final databaseProvider = Provider.of<Repository>(context);
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Shipping address',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                      onPressed: () => Navigator.of(context).pushNamed(
                          AppRoutes.viewAddressesPage,
                          arguments: databaseProvider),
                      icon: const Icon(Icons.exit_to_app))
                ],
              ),
              const SizedBox(height: 8),
              StreamBuilder<List<ShippingAddress>>(
                  stream: databaseProvider.getDefaultShippingAddress(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      final addresses = snapshot.data;
                      if (addresses == null || addresses.isEmpty) {
                        return SizedBox(
                          width: double.infinity,
                          child: Column(
                            children: [
                              const Text(
                                  'choose your default address or create one'),
                              const SizedBox(height: 4),
                              AddAddressButton(
                                database: databaseProvider,
                              ),
                            ],
                          ),
                        );
                      }
                      final defaultAddress = addresses.first;
                      return AddressTile(
                        address: defaultAddress,
                      );
                    }
                    return Center(child: CircularProgressIndicator.adaptive());
                  }),
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
              StreamBuilder<List<DeliveryOption>>(
                  stream: databaseProvider.deliveryOptions(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      final options = snapshot.data;
                      if (options == null || options.isEmpty) {
                        return const Center(
                            child: Text('No delievry options available'));
                      }
                      return SizedBox(
                        height: size.height * 0.15,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: options.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DeliveryOptionsTile(
                                deliveryOption: options[index],
                              ),
                            );
                          },
                        ),
                      );
                    }
                    return CircularProgressIndicator.adaptive();
                  }),
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
