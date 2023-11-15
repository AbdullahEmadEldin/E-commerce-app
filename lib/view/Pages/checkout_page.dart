import 'package:e_commerce_app/business_logic_layer/cart_cubit/cart_cubit.dart';
import 'package:e_commerce_app/business_logic_layer/user_preferences_cubit/user_perferences_cubit.dart';
import 'package:e_commerce_app/Utilities/routes.dart';
import 'package:e_commerce_app/data_layer/Models/address_model.dart';
import 'package:e_commerce_app/data_layer/Models/user_product.dart';
import 'package:e_commerce_app/data_layer/repository/firestore_repo.dart';
import 'package:e_commerce_app/view/Pages/landing_page.dart';
import 'package:e_commerce_app/view/Widgets/CheckoutWidgets/add_address_button.dart';
import 'package:e_commerce_app/view/Widgets/CheckoutWidgets/address_tile.dart';
import 'package:e_commerce_app/view/Widgets/main_button.dart';
import 'package:e_commerce_app/view/Widgets/paymentwidgets/payment_listener.dart';
import 'package:e_commerce_app/view/Widgets/two_separateditems_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutPage extends StatefulWidget {
  final int totalPrice;
  const CheckoutPage({Key? key, required this.totalPrice}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  List<UserProduct> orderProducts = [];
  late ShippingAddress defaultAddress;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    //search about why defining cubit with constructor not bloc provider fixed the problem DONEEEE
    ///by using Provider.of(context) you just access the cubit to instantiate new one
    ///but by using cubit constructor you instantiate new object which is not best practice
    BlocProvider.of<UserPrefCubit>(context).getDefaultShippingAddress();
    BlocProvider.of<CartCubit>(context).getCartProducts();
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
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, AppRoutes.viewAddressesPage,
                            arguments: 1);
                      },
                      child: Text(
                        'view all',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.red),
                      ))
                ],
              ),
              const SizedBox(height: 16),
              BlocBuilder<UserPrefCubit, UserPrefState>(
                //bloc: defaultAddressCubit,
                builder: (context, state) {
                  if (state is DefaultShippingAddressLoading) {
                    return const CircularProgressIndicator.adaptive();
                  } else if (state is DefaultShippingAddressSucess) {
                    if (state.shippingAddress!.isEmpty) {
                      return _emptyDefaultAddress();
                    }
                    defaultAddress = state.shippingAddress!.first;

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
              const SizedBox(height: 8),
              const Divider(thickness: 1),
              const SizedBox(height: 12),
              BlocBuilder<CartCubit, CartState>(
                builder: (context, state) {
                  if (state is SuccessCartProducts) {
                    orderProducts = state.cartProducts;

                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: orderProducts.length,
                        itemBuilder: (_, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(orderProducts[index].title),
                              Text(
                                'Size: ${orderProducts[index].size}, Color: ${orderProducts[index].color}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(color: Colors.grey),
                              )
                            ],
                          );
                        });
                  }
                  return Container();
                },
              ),
              const SizedBox(height: 12),
              const Divider(thickness: 1),
              TitleAndValueRow(
                  title: 'Order: ', value: '${widget.totalPrice}\$'),
              const SizedBox(height: 8),
              const TitleAndValueRow(title: 'Delivery: ', value: '15\$'),
              const SizedBox(height: 8),
              TitleAndValueRow(
                  title: 'Total: ', value: '${widget.totalPrice + 15}\$'),
              SizedBox(height: size.height * 0.25),
              MainButton(
                text: 'Confirm & Pay',
                ontap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (_) {
                        return MultiBlocProvider(
                          providers: [
                            BlocProvider(
                              create: (context) => CartCubit(
                                  cartRepository:
                                      FirestoreRepo(LandingPage.user!.uid)),
                            ),
                            BlocProvider(
                              create: (context) => UserPrefCubit(
                                  repository:
                                      FirestoreRepo(LandingPage.user!.uid)),
                            ),
                          ],
                          child: PaymentListner(
                            orderProducts: orderProducts,
                            defaultAddress: defaultAddress,
                            totalPrice: widget.totalPrice,
                          ),
                        );
                      });
                },
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
