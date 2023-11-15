// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_commerce_app/Utilities/assets.dart';
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

class PaymentOptionList extends StatefulWidget {
  const PaymentOptionList({Key? key}) : super(key: key);

  @override
  _PaymentOptionTileState createState() => _PaymentOptionTileState();
}

class _PaymentOptionTileState extends State<PaymentOptionList> {
  int isActiveIndex = 0;
  List<String> options = [AppAssets.cardImage, AppAssets.paypalLogo];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: options.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: GestureDetector(
          onTap: () {
            isActiveIndex = index;
            print(':::: $isActiveIndex');
            setState(() {});
          },
          child: PaymentOptionTile(
              isActive: isActiveIndex == index, image: options[index]),
        ),
      ),
    );
  }
}
