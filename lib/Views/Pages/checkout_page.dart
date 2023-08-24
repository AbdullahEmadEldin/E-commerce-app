import 'package:e_commerce_app/Controllers/database_controller.dart';
import 'package:e_commerce_app/Models/address_model.dart';
import 'package:e_commerce_app/Models/delivery_option.dart';
import 'package:e_commerce_app/Views/Widgets/CheckoutWidgets/add_address_button.dart';
import 'package:e_commerce_app/Views/Widgets/CheckoutWidgets/address_tile.dart';
import 'package:e_commerce_app/Views/Widgets/CheckoutWidgets/payment_tile.dart';
import 'package:e_commerce_app/Views/Widgets/main_button.dart';
import 'package:e_commerce_app/Views/Widgets/two_separateditems_row.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Widgets/CheckoutWidgets/delivery_options_tile.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final databaseProvider = Provider.of<Database>(context);
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
              StreamBuilder<List<UserAddress>>(
                  stream: databaseProvider.getUserAddresses(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      final addresses = snapshot.data;
                      if (addresses == null || addresses.isEmpty) {
                        return SizedBox(
                          width: double.infinity,
                          child: Column(
                            children: [
                              const Text(
                                  'You haven\'t add address yet, Click + to add '),
                              const SizedBox(height: 4),
                              AddAddressButton(
                                database: databaseProvider,
                              ),
                            ],
                          ),
                        );
                      }
                      //TODO: need to fetch the defult address from viewAddresses page
                      return AddressTile(
                        address: UserAddress(
                            id: '1234',
                            name: 'Name',
                            address: 'st. block no 47',
                            city: 'kafr',
                            state: 'qleen',
                            postalCode: '22334',
                            country: 'sdss'),
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
