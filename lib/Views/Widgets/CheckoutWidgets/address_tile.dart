import 'package:e_commerce_app/Models/address_model.dart';
import 'package:e_commerce_app/Utilities/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Controllers/database_controller.dart';

class AddressTile extends StatelessWidget {
  final UserAddress address;
  final bool inViewPage;
  const AddressTile({Key? key, required this.address, this.inViewPage = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context);
    return Card(
      key: Key(address.id),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  address.name,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                InkWell(
                    onTap: () => Navigator.of(context).pushNamed(
                        inViewPage
                            ? AppRoutes.addAddressPage
                            : AppRoutes.viewAddressesPage,
                        arguments: database),
                    child: Text(
                      inViewPage ? 'Edit' : 'Change',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: Colors.red),
                    ))
              ],
            ),
            const SizedBox(height: 8),
            Text(address.address),
            Text(
                '${address.city}, ${address.state} ${address.postalCode}, ${address.country}'),
          ],
        ),
      ),
    );
  }
}
