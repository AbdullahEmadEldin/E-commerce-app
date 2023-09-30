import 'package:e_commerce_app/business_logic_layer/user_preferences_cubit/user_perferences_cubit.dart';
import 'package:e_commerce_app/data_layer/Models/address_model.dart';
import 'package:e_commerce_app/view/Widgets/CheckoutWidgets/add_address_button.dart';
import 'package:e_commerce_app/view/Widgets/CheckoutWidgets/address_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewAddressesPage extends StatefulWidget {
  const ViewAddressesPage({Key? key}) : super(key: key);

  @override
  State<ViewAddressesPage> createState() => _ViewAddressesPageState();
}

class _ViewAddressesPageState extends State<ViewAddressesPage> {
  int? sharedValue = -1;
  int selectedIndex = -1;
  bool isDefault = false;
  List<ShippingAddress> defaultAddress = [];

  Future<void> _asyncTest() async {
    Future.delayed(const Duration(milliseconds: 200), () async {
      defaultAddress = BlocProvider.of<UserPrefCubit>(context).address;
      print('local addresses is empty ????  ${defaultAddress.isEmpty}');
      for (var address in defaultAddress) {
        print('looop order');
        if (address.isDefault) {
          selectedIndex = address.defaultIndex;
          sharedValue = address.defaultIndex;
          print(
              'selectedIndex is setted successfully == $selectedIndex, shared Vaaalue: $sharedValue');
        }
      }
    });
  }

  @override
  void initState() {
    BlocProvider.of<UserPrefCubit>(context).getAllAddress();
    Future.delayed(const Duration(milliseconds: 200), () async {
      await _asyncTest();
      print('future delayed &&& ${defaultAddress.isEmpty}');
    });
    print('INIT state after the future');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shipping Addresses'),
      ),
      body:
          //TODO: the first time you edit the default address ==> no problems
          //but when I pop back and open the page again and try to edit default address it throw a bad state
          //this in case of triggering the cubit inside build method
          BlocBuilder<UserPrefCubit, UserPrefState>(builder: (context, state) {
        if (state is ShippingAddressesLoading) {
          return const Center(child: CircularProgressIndicator.adaptive());
        } else if (state is ShippingAddressesSucess) {
          if (state.shippingAddress.isEmpty) {
            return const Center(
                child: Text('You Haven\'t Set your address yet'));
          }
          final addresses = state.shippingAddress;
          return _addressesListView(addresses);
        } else if (state is ShippingAddressesFailure) {
          return Center(child: Text('Error: ${state.errorMsg}'));
        } else if (state is SaveAddressSucess) {
          return _addressesListView(defaultAddress);
        } else {
          return Center(child: Text('the else state: ${state.toString()}'));
        }
      }),
      floatingActionButton: const AddAddressButton(),
    );
  }

  ListView _addressesListView(List<ShippingAddress> addresses) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: addresses.length,
      itemBuilder: (_, index) {
        return AddressTile(
          address: addresses[index],
          inViewPage: true,
          isDefaultButton: _isDefaultRadioButton(index, addresses),
        );
      },
    );
  }

  RadioListTile<dynamic> _isDefaultRadioButton(
      int index, List<ShippingAddress> addresses) {
    return RadioListTile(
      title: const Text('Default Shipping address'),
      value: index,
      groupValue: sharedValue,
      onChanged: (newValue) async {
        sharedValue = newValue;
        print(
            'first value of selected index::: $selectedIndex,data base index::  ${addresses[index].defaultIndex}');
        if (selectedIndex != -1) {
          addresses[selectedIndex].isDefault = false;
          await BlocProvider.of<UserPrefCubit>(context, listen: false)
              .saveUserAddress(addresses[selectedIndex]);
        }

        addresses[index].isDefault = true;
        addresses[index].defaultIndex = index;
        await BlocProvider.of<UserPrefCubit>(context, listen: false)
            .saveUserAddress(addresses[index]);
        selectedIndex = addresses[index].defaultIndex;
        print('selected indec::: $selectedIndex');
        setState(() {});
      },
      controlAffinity: ListTileControlAffinity.leading,
      contentPadding: EdgeInsets.zero,
    );
  }
}
