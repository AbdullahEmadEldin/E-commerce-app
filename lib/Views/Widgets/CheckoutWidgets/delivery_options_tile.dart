import 'package:flutter/material.dart';

class DeliveryOptionsTile extends StatelessWidget {
  final String imageSrc;
  final String daysForDelivery;
  const DeliveryOptionsTile(
      {Key? key, required this.imageSrc, required this.daysForDelivery})
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
                imageSrc,
                fit: BoxFit.cover,
                height: 50,
              ),
              Text(
                '$daysForDelivery days',
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
