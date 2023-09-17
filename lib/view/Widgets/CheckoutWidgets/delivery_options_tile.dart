import 'package:flutter/material.dart';

import '../../../data_layer/Models/delivery_option.dart';

class DeliveryOptionsTile extends StatelessWidget {
  final DeliveryOption deliveryOption;

  const DeliveryOptionsTile({Key? key, required this.deliveryOption})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: DecoratedBox(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Image.network(
                deliveryOption.imgUrl,
                fit: BoxFit.cover,
                height: 50,
              ),
              Text(
                '${deliveryOption.days} days',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
