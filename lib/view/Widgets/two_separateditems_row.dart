import 'package:flutter/material.dart';

class TitleAndValueRow extends StatelessWidget {
  final String title;
  final String value;

  const TitleAndValueRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .labelMedium!
              .copyWith(color: Colors.grey),
        ),
        Text(
          value,
          style: Theme.of(context)
              .textTheme
              .labelLarge!
              .copyWith(color: Colors.black),
        ),
      ],
    );
  }
}
