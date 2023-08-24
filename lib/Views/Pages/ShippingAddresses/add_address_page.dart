import 'package:e_commerce_app/Models/address_model.dart';
import 'package:e_commerce_app/Utilities/constants.dart';
import 'package:e_commerce_app/Views/Widgets/dialog.dart';
import 'package:e_commerce_app/Views/Widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Controllers/database_controller.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({Key? key}) : super(key: key);

  @override
  _AddAddressPageState createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  final _formKey = GlobalKey<FormState>();
  //fields controllers
  final _fullNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _zipcodeController = TextEditingController();
  final _countryController = TextEditingController();

  @override
  void dispose() {
    _addressController.dispose();
    _cityController.dispose();
    _countryController.dispose();
    _fullNameController.dispose();
    _stateController.dispose();
    _zipcodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final databaseProvider = Provider.of<Database>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Adding Shipping Address',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            child: Column(children: [
              TextFormField(
                controller: _fullNameController,
                decoration: const InputDecoration(
                    labelText: 'Full Name',
                    fillColor: Colors.white,
                    filled: true),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your name' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                    labelText: 'Address',
                    fillColor: Colors.white,
                    filled: true),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your address' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _cityController,
                decoration: const InputDecoration(
                    labelText: 'City', fillColor: Colors.white, filled: true),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your city' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _stateController,
                decoration: const InputDecoration(
                    labelText: 'State/Provinance',
                    fillColor: Colors.white,
                    filled: true),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your state' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _zipcodeController,
                decoration: const InputDecoration(
                    labelText: 'Zip Code',
                    fillColor: Colors.white,
                    filled: true),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your zip code' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _countryController,
                decoration: const InputDecoration(
                    labelText: 'Countrt',
                    fillColor: Colors.white,
                    filled: true),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your country' : null,
              ),
              const SizedBox(height: 32),
              MainButton(
                text: 'Save address',
                ontap: () => _saveAddress(databaseProvider),
                hasCircularBorder: true,
              )
            ]),
          ),
        ),
      ),
    );
  }

  Future<void> _saveAddress(Database database) async {
    try {
      if (_formKey.currentState!.validate()) {
        final address = UserAddress(
            id: kIdFromDartGenerator(),
            name: _fullNameController.text.trim(),
            address: _addressController.text.trim(),
            city: _cityController.text.trim(),
            state: _stateController.text.trim(),
            postalCode: _zipcodeController.text.trim(),
            country: _countryController.text.trim());
        await database.saveAddress(address);
        if (!mounted) return;
        Navigator.pop(context);
      }
    } catch (e) {
      MainDialog(
              context: context,
              title: 'Error saving address',
              content: e.toString())
          .showAlertDialog();
    }
  }
}
