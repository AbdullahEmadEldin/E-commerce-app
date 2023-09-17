import 'package:flutter/material.dart';

class FavouriteButton extends StatefulWidget {
  const FavouriteButton({Key? key}) : super(key: key);

  @override
  _FavouriteButtonState createState() => _FavouriteButtonState();
}

class _FavouriteButtonState extends State<FavouriteButton> {
  bool isFavourite = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isFavourite = !isFavourite;
        });
      },
      child: SizedBox(
        height: 50,
        width: 50,
        child: Material(
          elevation: 4.0,
          borderRadius: BorderRadius.circular(24),
          child: Icon(
              isFavourite ? Icons.favorite : Icons.favorite_border_rounded,
              color: Colors.red),
        ),
      ),
    );
  }
}
