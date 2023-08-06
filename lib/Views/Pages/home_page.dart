import 'package:e_commerce_app/Models/product.dart';
import 'package:e_commerce_app/Utilities/assets.dart';
import 'package:e_commerce_app/Views/Widgets/product_tile_home.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ListView(
      children: [
        Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Image.network(
              AppAssets.homePageBanner,
              width: double.infinity,
              height: size.height * 0.3,
              fit: BoxFit.cover,
            ),
            Opacity(
              opacity: 0.3,
              child: Container(
                width: double.infinity,
                height: size.height * 0.3,
                color: Colors.black,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Text(
                'Street Clothes',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            children: [
              _buildHeaderOfList(context,
                  title: 'Sale', description: 'Super Summer Sale!'),
              const SizedBox(height: 8),
              SizedBox(
                height: 300,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: dummyProducts
                      .map((e) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ProductTileHome(product: e),
                          ))
                      .toList(),
                ),
              ),
              _buildHeaderOfList(context,
                  title: 'New', description: 'Super New Products!'),
              const SizedBox(height: 8),
              SizedBox(
                height: 300,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: dummyProducts
                      .map((e) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ProductTileHome(product: e),
                          ))
                      .toList(),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderOfList(BuildContext context,
      {required String title,
      required String description,
      VoidCallback? onTap}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            InkWell(
              onTap: onTap,
              child: Text(
                'View All',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            )
          ],
        ),
        Text(
          description,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Colors.grey),
        )
      ],
    );
  }
}
