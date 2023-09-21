import 'package:e_commerce_app/business_logic_layer/user_preferences_cubit/user_perferences_cubit.dart';
import 'package:e_commerce_app/data_layer/Models/address_model.dart';
import 'package:e_commerce_app/view/Widgets/CheckoutWidgets/add_address_button.dart';
import 'package:e_commerce_app/view/Widgets/CheckoutWidgets/address_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewAddressesPage extends StatelessWidget {
  const ViewAddressesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userPrefCubit =
        BlocProvider.of<UserPrefCubit>(context).getAllAddress();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shipping Addresses'),
      ),
      body:
          //TODO: the first time you edit the default address ==> no problems
          //but when I pop back and open the page again and try to edit default address it throw a bad state
          BlocBuilder<UserPrefCubit, UserPrefState>(builder: (context, state) {
        if (state is ShippingAddressesLoading) {
          return const Center(child: CircularProgressIndicator.adaptive());
        } else if (state is ShippingAddressesSucess) {
          if (state.shippingAddress.isEmpty) {
            return const Center(
                child: Text('You Haven\'t Set your address yet'));
          }
          for (var address in state.shippingAddress) {
            if (address.isDefault != address.isDefault) {
              BlocProvider.of<UserPrefCubit>(context).getAllAddress();
            }
          }
          return ListView.builder(
            itemCount: state.shippingAddress.length,
            itemBuilder: (_, index) => AddressTile(
              address: state.shippingAddress[index],
              inViewPage: true,
            ),
          );
        } else if (state is ShippingAddressesFailure) {
          return Center(child: Text('Error: ${state.errorMsg}'));
        } else {
          print('stupid state: ${state.toString()}');
          return const Center(child: Text('a777aaaa state'));
        }
      }),
      floatingActionButton: const AddAddressButton(),
    );
  }
}
