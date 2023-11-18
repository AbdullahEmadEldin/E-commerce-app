import 'package:e_commerce_app/Utilities/assets.dart';
import 'package:e_commerce_app/business_logic_layer/product_cubit/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:e_commerce_app/data_layer/Models/product.dart';
import 'package:e_commerce_app/view/Widgets/product_tile_home.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.02, vertical: 16.0),
                child: Text(
                  'Fancy Clothes',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.02, vertical: size.height * 0.02),
          child: Column(
            children: [
              _buildHeaderOfList(context,
                  title: 'Sale', description: 'Super Summer Sale!'),
              SizedBox(height: size.height * 0.01),
              SizedBox(
                height: size.height * 0.365,
                child: _productsBlocBuilder(size,
                    emptyMsg: 'No sale products', isSaleProducts: true),
              ),
              _buildHeaderOfList(context,
                  title: 'New', description: 'Super New Products!'),
              SizedBox(height: size.height * 0.01),
              SizedBox(
                  height: size.height * 0.365,
                  child: _productsBlocBuilder(size,
                      emptyMsg: 'NO new products', isSaleProducts: false))
            ],
          ),
        ),
      ],
    );
  }

  BlocBuilder<ProductCubit, ProductState> _productsBlocBuilder(Size size,
      {required String emptyMsg, required bool isSaleProducts}) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SuccessfullyProductsLoaded) {
          final List<Product> products;
          isSaleProducts
              ? products = state.saleProducts
              : products = state.newProducts;
          if (products.isEmpty) {
            return const Center(child: Text('No Sale Products'));
          }
          return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              itemBuilder: (_, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ProductTileHome(
                      product: products[index],
                      isNew: products[index].discount == 0,
                      postions: (
                        favButtonBottomPostion: size.width * 0.15,
                        favButtonRightPostion: size.width * 0.01,
                        productDetailsBottom: size.height * 0.00001,
                        imageHeight: 200
                      ),
                    ),
                  ));
        } else if (state is ProductsFailure) {
          return Center(child: Text('Error: ${state.errorMsg}'));
        } else {
          return Center(child: Text('Some fucking state: ${state.toString()}'));
        }
      },
    );
  }

  Widget _buildHeaderOfList(
    BuildContext context, {
    required String title,
    required String description,
  }) {
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
