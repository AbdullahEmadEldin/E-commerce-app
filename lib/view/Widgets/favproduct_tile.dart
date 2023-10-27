import 'package:e_commerce_app/Utilities/routes.dart';
import 'package:e_commerce_app/business_logic_layer/product_cubit/product_cubit.dart';
import 'package:e_commerce_app/data_layer/Models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FavproductTile extends StatelessWidget {
  final Product product;
  const FavproductTile({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context, rootNavigator: true).pushNamed(
        AppRoutes.productDetails,
        arguments: product,
      ),
      child: SizedBox(
        height: 120,
        child: Card(
          elevation: 4,
          shape: const BeveledRectangleBorder(),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.elliptical(3, 3)),
                child: Image.network(
                  product.imgUrl,
                  fit: BoxFit.cover,
                  width: 120,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 1, 8, 4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            product.category,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: Colors.black26),
                          ),
                          IconButton(
                              onPressed: () {
                                BlocProvider.of<ProductCubit>(context)
                                    .deleteProductFromFav(product);
                              },
                              icon: const Icon(Icons.close))
                        ],
                      ),
                      Text(
                        product.title,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: Colors.black),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${product.price}\$',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: Colors.black),
                          ),
                          RatingBarIndicator(
                            rating: product.rate?.toDouble() ?? 0,
                            itemCount: product.rate ?? 0,
                            itemSize: 25,
                            itemBuilder: (context, rating) =>
                                const Icon(Icons.star, color: Colors.amber),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
