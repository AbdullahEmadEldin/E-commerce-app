import 'package:e_commerce_app/Utilities/ArgsModels/add_address_args.dart';
import 'package:flutter/material.dart';

import 'package:e_commerce_app/Utilities/routes.dart';
import '../../../data_layer/repository/firestore_repo.dart';

class AddAddressButton extends StatelessWidget {
  final Repository database;
  const AddAddressButton({Key? key, required this.database}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FloatingActionButton(
        backgroundColor: Colors.black,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.addAddressPage,
              arguments: AddShippingAddressArgs(database: database));
        },
      ),
    );
  }
}
