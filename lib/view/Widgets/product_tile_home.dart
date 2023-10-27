import 'package:e_commerce_app/business_logic_layer/product_cubit/product_cubit.dart';
import 'package:e_commerce_app/data_layer/Models/product.dart';
import 'package:e_commerce_app/Utilities/routes.dart';
import 'package:e_commerce_app/data_layer/repository/firestore_repo.dart';
import 'package:e_commerce_app/view/Pages/landing_page.dart';
import 'package:e_commerce_app/view/Widgets/favourite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductTileHome extends StatelessWidget {
  final Product product;
  final bool isNew;
  const ProductTileHome({Key? key, required this.product, this.isNew = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => ProductCubit(
          productsRepositroy: FirestoreRepo(LandingPage.user!.uid)),
      child: InkWell(
        onTap: () => Navigator.of(context, rootNavigator: true).pushNamed(
          AppRoutes.productDetails,
          arguments: product,
        ),
        child: DecoratedBox(
          decoration: const BoxDecoration(),
          child: Stack(
            children: [
              Stack(
                children: [
                  _imgBuilder(),
                  isNew ? _newBadge() : _discountBadge(),
                ],
              ),
              Positioned(
                  bottom: size.height * 0.1,
                  right: size.width * 0.01,
                  child: FavouriteButton(
                    product: product,
                  )),
              Positioned(
                bottom: size.height * 0.00001,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _ratingBar(),
                        const SizedBox(width: 4),
                        //TODO: this number will be fetched from firestore
                        const Text('(96)', style: TextStyle(color: Colors.grey))
                      ],
                    ),
                    Text(
                      '${product.category}',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: const Color.fromARGB(255, 117, 117, 117)),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      '${product.title}',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 4.0),
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

  RatingBarIndicator _ratingBar() {
    return RatingBarIndicator(
      rating: product.rate?.toDouble() ?? 0,
      itemCount: product.rate ?? 0,
      itemSize: 25,
      itemBuilder: (context, rating) =>
          const Icon(Icons.star, color: Colors.amber),
    );
  }

  ClipRRect _imgBuilder() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.network(
        product.imgUrl,
        fit: BoxFit.cover,
        height: 200,
        width: 220,
      ),
    );
  }

  Widget _discountBadge() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 25,
        width: 40,
        decoration: BoxDecoration(
            color: Colors.red, borderRadius: BorderRadius.circular(20)),
        child: Center(
            child: Text(
          "-${product.discount}%",
          style: const TextStyle(color: Colors.white),
        )),
      ),
    );
  }

  Widget _newBadge() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 25,
        width: 40,
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(20)),
        child: const Center(
            child: Text(
          "New",
          style: TextStyle(color: Colors.white),
        )),
      ),
    );
  }
}
