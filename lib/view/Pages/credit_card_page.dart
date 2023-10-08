import 'package:e_commerce_app/business_logic_layer/user_preferences_cubit/user_perferences_cubit.dart';
import 'package:e_commerce_app/view/Widgets/dialog.dart';
import 'package:e_commerce_app/view/Widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class CreditCardPage extends StatefulWidget {
  final int paymentPrice;
  const CreditCardPage({Key? key, this.paymentPrice = 0}) : super(key: key);

  @override
  _CreditCardPageState createState() => _CreditCardPageState();
}

class _CreditCardPageState extends State<CreditCardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Credit Card'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CardFormField(
                  controller: CardFormEditController(),
                  style: CardFormStyle(
                      textColor: Colors.black,
                      cursorColor: Colors.red,
                      placeholderColor: Colors.black,
                      borderRadius: 2,
                      borderWidth: 1),
                ),
              ),
              BlocListener<UserPrefCubit, UserPrefState>(
                listener: (context, state) {
                  bool paymentSuccess = false;
                  bool paymentFailure = false;
                  String errMsg = '';
                  if (state is PaymentLoading) {
                  } else if (state is PaymentSuccess) {
                    paymentSuccess = true;
                  } else if (state is PaymentFailure) {
                    paymentFailure = true;
                    errMsg = state.errorMsg;
                  }
                  paymentSuccess
                      ? MainDialog(
                          context: context,
                          title: ' Payment process',
                          content: 'Payment done successfully',
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
                          .makePayment(widget.paymentPrice, 'USD');
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
