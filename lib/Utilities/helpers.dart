import 'package:flutter/material.dart';

Text textRichBuilder(BuildContext context,
    {required String text1, required String text2}) {
  return Text.rich(TextSpan(children: [
    TextSpan(
      text: text1,
      style: Theme.of(context).textTheme.titleSmall!.copyWith(
            color: Colors.grey,
          ),
    ),
    TextSpan(text: text2, style: const TextStyle(color: Colors.black)),
  ]));
}
