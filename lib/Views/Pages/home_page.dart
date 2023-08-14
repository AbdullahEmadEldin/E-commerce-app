import 'package:e_commerce_app/Controllers/database_controller.dart';
import 'package:e_commerce_app/Models/product.dart';
import 'package:e_commerce_app/Utilities/assets.dart';
import 'package:e_commerce_app/Views/Widgets/product_tile_home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    ///to use provider of database you need to make that provider a parent widget
    final databaseProvider = Provider.of<Database>(context);
    return ListView(
      children: [
        Stack(
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
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 16.0),
                child: Text(
                  'Street Clothes',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
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
                //to consume data coming from database as stream you need to create a StreamBuilder
                child: StreamBuilder<List<Product>>(
                    stream: databaseProvider.salesProductStream(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        final productsList = snapshot.data;
                        if (productsList == null || productsList.isEmpty) {
                          return const Center(child: Text('No data available'));
                        }
                        return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: productsList.length,
                            itemBuilder: (_, index) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ProductTileHome(
                                      product: productsList[index]),
                                ));
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
              ),
              _buildHeaderOfList(context,
                  title: 'New', description: 'Super New Products!'),
              const SizedBox(height: 8),
              SizedBox(
                height: 300,
                child: StreamBuilder<List<Product>>(
                    stream: databaseProvider.newProductStream(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        final productsList = snapshot.data;
                        if (productsList == null || productsList.isEmpty) {
                          return const Center(child: Text('No data available'));
                        }
                        return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: productsList.length,
                            //TODO: when replaced with real firebase database the productTile conditons doesn't work
                            itemBuilder: (_, index) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ProductTileHome(
                                      product: productsList[index]),
                                ));
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
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
