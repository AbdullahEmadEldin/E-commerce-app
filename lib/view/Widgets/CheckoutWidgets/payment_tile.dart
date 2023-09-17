import 'package:e_commerce_app/Utilities/assets.dart';
import 'package:flutter/material.dart';

class PaymentTile extends StatelessWidget {
  const PaymentTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), color: Colors.white),
          child: Image.network(
            AppAssets.mastercardLogo,
            fit: BoxFit.cover,
            height: 70,
          ),
        ),
        const SizedBox(width: 16),
        Text(
          '**** **** **** 1234',
          style: Theme.of(context).textTheme.titleMedium,
        )
      ],
    );
  }
}
