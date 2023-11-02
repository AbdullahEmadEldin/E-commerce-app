import 'package:e_commerce_app/Utilities/assets.dart';
import 'package:e_commerce_app/view/Widgets/paymentwidgets/creditcard_info.dart';
import 'package:e_commerce_app/view/Widgets/paymentwidgets/payment_option_tile.dart';

import 'package:flutter/material.dart';

class CreditCardPage extends StatefulWidget {
  final int paymentPrice;
  const CreditCardPage({Key? key, this.paymentPrice = 0}) : super(key: key);

  @override
  _CreditCardPageState createState() => _CreditCardPageState();
}

class _CreditCardPageState extends State<CreditCardPage> {
  int isActiveIndex = 0;
  List<String> options = [AppAssets.cardImage, AppAssets.paypalLogo];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Details'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 85, child: _paymentOptionList()),
              CreditcardInfo(
                paymentPrice: widget.paymentPrice,
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListView _paymentOptionList() {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: options.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: GestureDetector(
          onTap: () {
            isActiveIndex = index;
            setState(() {});
          },
          child: PaymentOptionTile(
              isActive: isActiveIndex == index, image: options[index]),
        ),
      ),
    );
  }
}
