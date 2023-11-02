import 'package:e_commerce_app/business_logic_layer/user_preferences_cubit/user_perferences_cubit.dart';
import 'package:e_commerce_app/view/Widgets/dialog.dart';
import 'package:e_commerce_app/view/Widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class CreditcardInfo extends StatefulWidget {
  final int paymentPrice;
  const CreditcardInfo({Key? key, required this.paymentPrice})
      : super(key: key);

  @override
  _CreditcardInfoState createState() => _CreditcardInfoState();
}

class _CreditcardInfoState extends State<CreditcardInfo> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CreditCardWidget(
            height: 200,
            cardNumber: '',
            expiryDate: '',
            cardHolderName: '',
            cvvCode: '',
            showBackView: false,
            isHolderNameVisible: true,
            onCreditCardWidgetChange: (CreditCardBrand creditCardBrand) {},
            cardBgColor: Colors.black,
          ),
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
          const SizedBox(height: 8),
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
    );
  }
}
