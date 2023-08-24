import 'package:flutter/material.dart';

import 'package:e_commerce_app/Utilities/routes.dart';
import '../../../Controllers/database_controller.dart';

class AddAddressButton extends StatelessWidget {
  final Database database;
  const AddAddressButton({Key? key, required this.database}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FloatingActionButton(
        backgroundColor: Colors.black,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .pushNamed(AppRoutes.addAddressPage, arguments: database);
        },
      ),
    );
  }
}
