// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class PaymentOptionTile extends StatelessWidget {
  final String image;
  final bool isActive;
  const PaymentOptionTile({
    Key? key,
    required this.image,
    required this.isActive,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 150,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(
              width: 1.50,
              color: isActive ? Color(0xFF34A853) : Colors.black26),
          borderRadius: BorderRadius.circular(15),
        ),
        shadows: [
          BoxShadow(
            color: isActive ? Color(0xFF34A853) : Colors.black26,
            blurRadius: 4,
            offset: Offset(0, 0),
            spreadRadius: 0,
          )
        ],
      ),
      child: Image.asset(
        image,
        fit: BoxFit.scaleDown,
      ),
    );
  }
}
