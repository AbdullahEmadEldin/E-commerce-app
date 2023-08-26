import 'package:e_commerce_app/Controllers/database_controller.dart';
import 'package:e_commerce_app/Models/address_model.dart';
import 'package:e_commerce_app/Views/Widgets/CheckoutWidgets/add_address_button.dart';
import 'package:e_commerce_app/Views/Widgets/CheckoutWidgets/address_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewAddressesPage extends StatelessWidget {
  const ViewAddressesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final databaseProvider = Provider.of<Database>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shipping Addresses'),
      ),
      body: StreamBuilder<List<ShippingAddress>>(
          stream: databaseProvider.getShippingAddresses(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              final addresses = snapshot.data;

              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: ListView.builder(
                  itemCount: addresses!.length,
                  itemBuilder: (_, index) => AddressTile(
                    address: addresses[index],
                    inViewPage: true,
                  ),
                ),
              );
            }
            return const Center(child: CircularProgressIndicator.adaptive());
          }),
      floatingActionButton: AddAddressButton(database: databaseProvider),
    );
  }
}
