// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_commerce_app/business_logic_layer/product_cubit/product_cubit.dart';
import 'package:e_commerce_app/data_layer/Models/product.dart';
import 'package:e_commerce_app/data_layer/repository/firestore_repo.dart';
import 'package:e_commerce_app/view/Pages/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouriteButton extends StatefulWidget {
  final Product product;
  FavouriteButton({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  _FavouriteButtonState createState() => _FavouriteButtonState();
}

class _FavouriteButtonState extends State<FavouriteButton> {
  bool isFavourite = false;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit(
          productsRepositroy: FirestoreRepo(LandingPage.user!.uid)),
      child: InkWell(
        onTap: () {
          setState(() {
            isFavourite = !isFavourite;
            BlocProvider.of<ProductCubit>(context).addFavouriteProduct(
                widget.product.compywith(isFavourite: isFavourite));
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
      ),
    );
  }
}
