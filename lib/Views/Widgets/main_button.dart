import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final String text;
  final VoidCallback ontap;
  final bool hasCircularBorder;
  const MainButton(
      {Key? key,
      required this.text,
      required this.ontap,
      this.hasCircularBorder = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      //decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      child: ElevatedButton(
        onPressed: ontap,
        style: ElevatedButton.styleFrom(
            shape: hasCircularBorder
                ? RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  )
                : null),
        child: Text(text),
      ),
    );
  }
}
