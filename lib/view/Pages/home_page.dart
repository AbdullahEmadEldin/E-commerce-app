import 'package:e_commerce_app/Utilities/assets.dart';
import 'package:e_commerce_app/business_logic_layer/product_cubit/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:e_commerce_app/data_layer/Models/product.dart';
import 'package:e_commerce_app/view/Widgets/product_tile_home.dart';

class HomePage extends StatelessWidget {
  late List<Product> saleProducts;
  late List<Product> newProducts;

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProductCubit>(context).retrieveAllProducts();
    final size = MediaQuery.of(context).size;

    return ListView(
      children: [
        Stack(
          children: [
            Image.asset(
              AppAssets.homePagePanner,
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
                child: BlocBuilder<ProductCubit, ProductState>(
                  builder: (context, state) {
                    if (state is ProductsLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is SuccessfullyProductsLoaded) {
                      saleProducts = state.saleProducts;
                      if (saleProducts.isEmpty) {
                        return const Center(child: Text('No Sale Products'));
                      }
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: saleProducts.length,
                          itemBuilder: (_, index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ProductTileHome(
                                  product: saleProducts[index],
                                  isNew: false,
                                ),
                              ));
                    } else if (state is ProductsFailure) {
                      return Center(child: Text('Error: ${state.errorMsg}'));
                    } else {
                      BlocProvider.of<ProductCubit>(context)
                          .retrieveAllProducts();

                      return Center(
                          child:
                              Text('Some fucking state: ${state.toString()}'));
                    }
                  },
                ),
              ),
              _buildHeaderOfList(context,
                  title: 'New', description: 'Super New Products!'),
              const SizedBox(height: 8),
              SizedBox(
                height: 300,
                child: BlocBuilder<ProductCubit, ProductState>(
                  builder: (context, state) {
                    if (state is ProductsLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is SuccessfullyProductsLoaded) {
                      newProducts = state.newProducts;
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: newProducts.length,
                          itemBuilder: (_, index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ProductTileHome(
                                  product: newProducts[index],
                                  isNew: true,
                                ),
                              ));
                    } else if (state is ProductsFailure) {
                      return Center(child: Text('Error: ${state.errorMsg}'));
                    } else {
                      return Center(
                          child:
                              Text('Some fucking state: ${state.toString()}'));
                    }
                  },
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
