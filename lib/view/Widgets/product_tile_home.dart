import 'package:e_commerce_app/business_logic_layer/product_cubit/product_cubit.dart';
import 'package:e_commerce_app/data_layer/Models/product.dart';
import 'package:e_commerce_app/Utilities/routes.dart';
import 'package:e_commerce_app/data_layer/repository/firestore_repo.dart';
import 'package:e_commerce_app/view/Pages/landing_page.dart';
import 'package:e_commerce_app/view/Widgets/favourite_button.dart';
import 'package:e_commerce_app/view/Widgets/product_tile_widgets/badges.dart';
import 'package:e_commerce_app/view/Widgets/product_tile_widgets/ratingbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductTileHome extends StatelessWidget {
  final Product product;
  final bool isNew;
  final ({
    double favButtonBottomPostion,
    double favButtonRightPostion,
    double productDetailsBottom,
    double imageHeight
  }) postions;
  const ProductTileHome(
      {Key? key,
      required this.product,
      required this.postions,
      this.isNew = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => ProductCubit(
          productsRepositroy: FirestoreRepo(LandingPage.user!.uid)),
      child: InkWell(
        //!! what does rootNavigator = true do ??
        //it make the new page seperated from the context of the bottomNavigationBar
        onTap: () => Navigator.of(context, rootNavigator: true).pushNamed(
          AppRoutes.productDetails,
          arguments: product,
        ),
        child: DecoratedBox(
          decoration: const BoxDecoration(),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Stack(
                children: [
                  _imgBuilder(size),
                  ProductBadge(
                    product: product,
                    isNew: isNew,
                  ),
                ],
              ),
              Positioned(
                  bottom: postions.favButtonBottomPostion,
                  right: postions.favButtonRightPostion,
                  child: FavouriteButton(
                    product: product,
                  )),
              Positioned(
                bottom: postions.productDetailsBottom,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ProductRatingBar(product: product),
                        SizedBox(width: size.width * 0.003),
                        const Text('(96)', style: TextStyle(color: Colors.grey))
                      ],
                    ),
                    Text(
                      product.category,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: const Color.fromARGB(255, 117, 117, 117)),
                    ),
                    SizedBox(width: size.width * 0.003),
                    Text(
                      product.title,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    SizedBox(width: size.width * 0.003),
                    Text.rich(TextSpan(children: [
                      TextSpan(
                        text: '${product.price}\$',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: const Color.fromARGB(255, 110, 110, 110),
                            decoration: product.discount == null ||
                                    product.discount == 0
                                ? null
                                : TextDecoration.lineThrough),
                      ),
                      product.discount == null || product.discount == 0
                          ? const TextSpan()
                          : TextSpan(
                              text:
                                  '  ${product.price - (product.price * (product.discount ?? 0)) / 100}\$',
                              style: const TextStyle(color: Colors.red)),
                    ])),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  ClipRRect _imgBuilder(Size size) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.network(
        product.imgUrl,
        fit: BoxFit.cover,
        height: postions.imageHeight,
        width: size.width * 0.5,
      ),
    );
  }
}
