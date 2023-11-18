import 'package:e_commerce_app/business_logic_layer/user_preferences_cubit/user_perferences_cubit.dart';
import 'package:e_commerce_app/data_layer/Models/address_model.dart';
import 'package:e_commerce_app/Utilities/constants.dart';
import 'package:e_commerce_app/view/Widgets/dialog.dart';
import 'package:e_commerce_app/view/Widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddAddressPage extends StatefulWidget {
  final ShippingAddress? shippingAddress;
  const AddAddressPage({Key? key, this.shippingAddress}) : super(key: key);

  @override
  _AddAddressPageState createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  bool saveAddressDone = false;
  bool saveAddressFailed = false;
  final _formKey = GlobalKey<FormState>();
  //fields controllers
  final _fullNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _zipcodeController = TextEditingController();
  final _countryController = TextEditingController();
  ShippingAddress? shippingAddress;
  @override
  void initState() {
    super.initState();
    shippingAddress = widget.shippingAddress;
    if (shippingAddress != null) {
      _fullNameController.text = shippingAddress!.name;
      _addressController.text = shippingAddress!.address;
      _cityController.text = shippingAddress!.city;
      _stateController.text = shippingAddress!.state;
      _zipcodeController.text = shippingAddress!.postalCode;
      _countryController.text = shippingAddress!.country;
    }
  }

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
    final size = MediaQuery.of(context).size;
    final saveAddressCubit = BlocProvider.of<UserPrefCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          shippingAddress != null
              ? 'Adding Shipping Address'
              : 'Editing Shipping Address',
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
              SizedBox(height: size.height * 0.02),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                    labelText: 'Address',
                    fillColor: Colors.white,
                    filled: true),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your address' : null,
              ),
              SizedBox(height: size.height * 0.02),
              TextFormField(
                controller: _cityController,
                decoration: const InputDecoration(
                    labelText: 'City', fillColor: Colors.white, filled: true),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your city' : null,
              ),
              SizedBox(height: size.height * 0.02),
              TextFormField(
                controller: _stateController,
                decoration: const InputDecoration(
                    labelText: 'State/Provinance',
                    fillColor: Colors.white,
                    filled: true),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your state' : null,
              ),
              SizedBox(height: size.height * 0.02),
              TextFormField(
                controller: _zipcodeController,
                decoration: const InputDecoration(
                    labelText: 'Zip Code',
                    fillColor: Colors.white,
                    filled: true),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your zip code' : null,
              ),
              SizedBox(height: size.height * 0.02),
              TextFormField(
                controller: _countryController,
                decoration: const InputDecoration(
                    labelText: 'Country',
                    fillColor: Colors.white,
                    filled: true),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your country' : null,
              ),
              SizedBox(height: size.height * 0.25),
              BlocListener<UserPrefCubit, UserPrefState>(
                listener: (context, state) {
                  if (state is SaveAddressSucess) {
                    saveAddressDone = true;
                  } else if (state is SaveAddressFailed) {
                    saveAddressFailed = true;
                  }

                  saveAddressDone
                      ? MainDialog(
                          context: context,
                          title: ' saving address',
                          content: 'Address saved successfully',
                        ).showAlertDialog()
                      : const SizedBox();
                  saveAddressFailed
                      ? MainDialog(
                              context: context,
                              title: 'Error saving address',
                              content: 'state.errorMsg.toString()')
                          .showAlertDialog()
                      : const SizedBox();
                },
                child: MainButton(
                  text: 'Save address',
                  ontap: () async {
                    if (_formKey.currentState!.validate()) {
                      await saveAddressCubit.saveUserAddress(ShippingAddress(
                          id: shippingAddress != null
                              ? shippingAddress!.id
                              : kIdDartAutoGenerator(),
                          name: _fullNameController.text.trim(),
                          address: _addressController.text.trim(),
                          city: _cityController.text.trim(),
                          state: _stateController.text.trim(),
                          postalCode: _zipcodeController.text.trim(),
                          country: _countryController.text.trim()));
                    }
                  },
                  hasCircularBorder: true,
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
