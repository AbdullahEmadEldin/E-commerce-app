import 'package:e_commerce_app/Utilities/constants.dart';
import 'package:e_commerce_app/business_logic_layer/cart_cubit/cart_cubit.dart';
import 'package:e_commerce_app/business_logic_layer/user_preferences_cubit/user_perferences_cubit.dart';
import 'package:e_commerce_app/data_layer/Models/address_model.dart';
import 'package:e_commerce_app/data_layer/Models/order.dart';
import 'package:e_commerce_app/data_layer/Models/user_product.dart';
import 'package:e_commerce_app/data_layer/repository/firestore_repo.dart';
import 'package:e_commerce_app/view/Pages/landing_page.dart';
import 'package:e_commerce_app/view/Widgets/dialog.dart';
import 'package:e_commerce_app/view/Widgets/main_button.dart';
import 'package:e_commerce_app/view/Widgets/paymentwidgets/payment_option_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentListner extends StatelessWidget {
  final List<UserProduct> orderProducts;
  final ShippingAddress defaultAddress;
  final int totalPrice;
  const PaymentListner({
    super.key,
    required this.orderProducts,
    required this.defaultAddress,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 85, child: PaymentOptionList()),
          const SizedBox(height: 16),
          BlocListener<UserPrefCubit, UserPrefState>(
            listener: (context, state) {
              bool paymentSuccess = false;
              bool paymentFailure = false;
              String errMsg = '';
              if (state is PaymentLoading) {
              } else if (state is PaymentSuccess) {
                final DateTime today = DateTime.now();
                paymentSuccess = true;
                BlocProvider.of<UserPrefCubit>(context).createOrder(Order(
                    id: kIdDartAutoGenerator(),
                    totalPrice: totalPrice,
                    products: orderProducts,
                    address: defaultAddress,
                    date: '${today.day}-${today.month}-${today.year}'));
                BlocProvider.of<CartCubit>(context)
                    .clearCartAfterSuccessfulOrder();
              } else if (state is PaymentFailure) {
                paymentFailure = true;
                errMsg = state.errorMsg;
                print('prooomleemaa');
              }
              paymentSuccess
                  ? MainDialog(
                      context: context,
                      title: ' Payment process',
                      content: 'Successful Payment. Order placed successfully',
                    ).showAlertDialog()
                  : const SizedBox();
              paymentFailure
                  ? MainDialog(
                      context: context,
                      title: ' Payment process Error',
                      content: 'Error: $errMsg',
                    ).showAlertDialog()
                  : const SizedBox();
            },
            child: MainButton(
                text: 'Pay',
                ontap: () {
                  BlocProvider.of<UserPrefCubit>(context)
                      .makePayment(totalPrice, 'USD');
                }),
          ),
        ],
      ),
    );
  }
}
