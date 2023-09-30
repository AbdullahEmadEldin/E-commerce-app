import 'package:e_commerce_app/business_logic_layer/user_preferences_cubit/user_perferences_cubit.dart';
import 'package:e_commerce_app/data_layer/Models/address_model.dart';
import 'package:e_commerce_app/Utilities/routes.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressTile extends StatefulWidget {
  final ShippingAddress address;
  final bool inViewPage;
  final RadioListTile? isDefaultButton;
  AddressTile(
      {Key? key,
      required this.address,
      this.inViewPage = false,
      this.isDefaultButton})
      : super(key: key);

  @override
  State<AddressTile> createState() => _AddressTileState();
}

class _AddressTileState extends State<AddressTile> {
  bool isDefault = false;

  @override
  // void initState() {
  //   super.initState();
  //   isDefault = widget.address.isDefault;
  //   if (isDefault) sharedRadioValue = widget.index;
  // }

  @override
  Widget build(BuildContext context) {
    // final database = Provider.of<Repository>(context);

    return Card(
      key: Key(widget.address.id),
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
                  widget.address.name,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                _editAddress(context)
              ],
            ),
            const SizedBox(height: 8),
            Text(widget.address.address),
            Text(
                '${widget.address.city}, ${widget.address.state} ${widget.address.postalCode}, ${widget.address.country}'),
            Text('is Default: ${widget.address.isDefault}'),
            widget.inViewPage ? widget.isDefaultButton! : const SizedBox()
          ],
        ),
      ),
    );
  }

  InkWell _editAddress(BuildContext context) {
    return InkWell(
        onTap: () {
          widget.inViewPage
              ? Navigator.of(context).pushNamed(AppRoutes.addAddressPage,
                  arguments: widget.address)
              : Navigator.of(context).pushNamed(
                  AppRoutes.viewAddressesPage,
                  // arguments: database
                );
        },
        child: Text(
          widget.inViewPage ? 'Edit' : 'Change',
          style: Theme.of(context)
              .textTheme
              .labelLarge!
              .copyWith(color: Colors.red),
        ));
  }
}
