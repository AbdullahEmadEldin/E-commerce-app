import 'package:e_commerce_app/business_logic_layer/product_cubit/product_cubit.dart';

import 'package:e_commerce_app/view/Widgets/favproduct_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouritesPage extends StatelessWidget {
  const FavouritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProductCubit>(context).retrieveAllProducts();
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourite Products'),
        centerTitle: true,
      ),
      body: BlocBuilder<ProductCubit, ProductState>(builder: (context, state) {
        if (state is ProductsLoading) {
          return const Center(child: CircularProgressIndicator.adaptive());
        } else if (state is SuccessfullyProductsLoaded) {
          final favProducts = state.favProducts;
          if (favProducts.isEmpty) {
            return const Center(child: Text('No Favourite products'));
          }
          return ListView.builder(
              itemCount: favProducts.length,
              itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FavproductTile(product: favProducts[index]),
                  ));
        } else if (state is ProductsFailure) {
          return Center(
              child: Text('Error fetching fav products ${state.errorMsg}'));
        } else {
          return Center(
              child: Text('Some un expected state Error  ${state.toString()}'));
        }
      }),
    );
  }
}
