import 'package:e_commerce_app/business_logic_layer/user_preferences_cubit/user_perferences_cubit.dart';
import 'package:e_commerce_app/data_layer/Models/address_model.dart';
import 'package:e_commerce_app/Utilities/routes.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressTile extends StatefulWidget {
  final ShippingAddress address;
  final bool inViewPage;
  final RadioListTile? isDefaultButton;
  const AddressTile(
      {Key? key,
      required this.address,
      this.inViewPage = false,
      this.isDefaultButton})
      : super(key: key);

  @override
  State<AddressTile> createState() => _AddressTileState();
}

class _AddressTileState extends State<AddressTile> {
  int sharedValue = -1;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(16),
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
            SizedBox(height: size.height * 0.001),
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

  Widget _editAddress(BuildContext context) {
    return widget.inViewPage
        ? PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              if (value == 'Edit') {
                Navigator.of(context).pushNamed(AppRoutes.addAddressPage,
                    arguments: widget.address);
              } else if (value == 'Delete') {
                BlocProvider.of<UserPrefCubit>(context)
                    .deleteAddress(widget.address);
              }
            },
            itemBuilder: (context) => [
                  const PopupMenuItem<String>(
                    value: 'Edit',
                    child: Text('Edit'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'Delete',
                    child: Text('Delete'),
                  ),
                ])
        : InkWell(
            onTap: () {
              widget.address.isDefault
                  ? sharedValue = widget.address.defaultIndex
                  : sharedValue;
              Navigator.of(context).pushNamed(AppRoutes.viewAddressesPage,
                  arguments: sharedValue);
            },
            child: Text(
              'Change',
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(color: Colors.red),
            ));
  }
}
