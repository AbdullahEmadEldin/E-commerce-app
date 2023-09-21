import 'package:e_commerce_app/business_logic_layer/user_preferences_cubit/user_perferences_cubit.dart';
import 'package:e_commerce_app/Utilities/routes.dart';
import 'package:e_commerce_app/data_layer/repository/firestore_repo.dart';
import 'package:e_commerce_app/view/Pages/landing_page.dart';
import 'package:e_commerce_app/view/Widgets/CheckoutWidgets/add_address_button.dart';
import 'package:e_commerce_app/view/Widgets/CheckoutWidgets/address_tile.dart';
import 'package:e_commerce_app/view/Widgets/CheckoutWidgets/delivery_options_tile.dart';
import 'package:e_commerce_app/view/Widgets/CheckoutWidgets/payment_tile.dart';
import 'package:e_commerce_app/view/Widgets/main_button.dart';
import 'package:e_commerce_app/view/Widgets/two_separateditems_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    //TODO: search about why defining cubit with constructor not bloc provider fixed the problem
    final defaultAddressCubit =
        UserPrefCubit(repository: FirestoreRepo(LandingPage.user!.uid));
    defaultAddressCubit.getDefaultShippingAddress();
    final deliveryOptionnCubit = BlocProvider.of<UserPrefCubit>(context);
    deliveryOptionnCubit.getDeliveryOptions();
    //final databaseProvider = Provider.of<Repository>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Shipping address',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                      onPressed: () => Navigator.of(context).pushNamed(
                            AppRoutes.viewAddressesPage,
                            // arguments: databaseProvider
                          ),
                      icon: const Icon(Icons.exit_to_app))
                ],
              ),
              const SizedBox(height: 8),
              BlocBuilder<UserPrefCubit, UserPrefState>(
                bloc: defaultAddressCubit,
                buildWhen: (previous, current) {
                  return current != previous;
                },
                builder: (context, state) {
                  if (state is DefaultShippingAddressLoading) {
                    return const CircularProgressIndicator.adaptive();
                  } else if (state is DefaultShippingAddressSucess) {
                    print('Uiiiiiiiiiiiiiiiiiiiiii default adddress');
                    if (state.shippingAddress!.isEmpty) {
                      return _emptyDefaultAddress();
                    }
                    final defaultAddress = state.shippingAddress!.first;
                    return AddressTile(
                      address: defaultAddress,
                    );
                  } else if (state is DefaultShippingAddressFailure) {
                    return Center(
                      child: Text('error: ${state.errorMsg}'),
                    );
                  } else {
                    return const Center(
                      child:
                          Text('User preferences inital state, SOME ProBlem'),
                    );
                  }
                },
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Payment',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                      onTap: () {},
                      child: Text(
                        'change',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: Colors.red),
                      ))
                ],
              ),
              const SizedBox(height: 16),
              const PaymentTile(),
              const SizedBox(height: 32),
              Text(
                'Delivery options',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              BlocBuilder<UserPrefCubit, UserPrefState>(
                  bloc: deliveryOptionnCubit,
                  builder: (context, state) {
                    if (state is DelvieryOptionsLoading) {
                      return const CircularProgressIndicator.adaptive();
                    } else if (state is DelvieryOptionsSucess) {
                      if (state.deliveryOptions.isEmpty) {
                        return const Center(
                            child: Text('No delievry options available'));
                      }
                      return SizedBox(
                        height: size.height * 0.15,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.deliveryOptions.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DeliveryOptionsTile(
                                deliveryOption: state.deliveryOptions[index],
                              ),
                            );
                          },
                        ),
                      );
                    } else if (state is DeliveryOptionsFailure) {
                      return Center(
                        child: Text(
                            'Error fetching delivery options: ${state.errorMsg}'),
                      );
                    } else {
                      return const Center(
                          child: Text(
                              'this is the DeliveryOptionInitial state SOME PROBLEM'));
                    }
                  }),
              const SizedBox(height: 16),
              const TitleAndValueRow(title: 'Order: ', value: '150\$'),
              const SizedBox(height: 8),
              const TitleAndValueRow(title: 'Delivery: ', value: '15\$'),
              const SizedBox(height: 8),
              const TitleAndValueRow(title: 'Total: ', value: '165\$'),
              const SizedBox(height: 16),
              MainButton(
                text: 'Submit order',
                ontap: () {},
                hasCircularBorder: true,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox _emptyDefaultAddress() {
    return const SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Text('choose your default address or create one'),
          SizedBox(height: 4),
          AddAddressButton(),
        ],
      ),
    );
  }
}
