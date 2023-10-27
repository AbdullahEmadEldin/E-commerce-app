import 'package:e_commerce_app/business_logic_layer/product_cubit/product_cubit.dart';
import 'package:e_commerce_app/data_layer/Models/product.dart';
import 'package:e_commerce_app/data_layer/repository/firestore_repo.dart';
import 'package:e_commerce_app/view/Pages/landing_page.dart';
import 'package:e_commerce_app/view/Widgets/favproduct_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouritesPage extends StatelessWidget {
  const FavouritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favbloc =
        ProductCubit(productsRepositroy: FirestoreRepo(LandingPage.user!.uid));
    favbloc.getFavProducts();
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourite Products'),
        centerTitle: true,
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
          bloc: favbloc,
          builder: (context, state) {
            if (state is FavProductsLoading) {
              return const Center(child: CircularProgressIndicator.adaptive());
            } else if (state is FavProductsFetched) {
              final favProducts = state.fav;
              if (favProducts.isEmpty) {
                return const Center(child: Text('No Favourite products'));
              }
              return ListView.builder(
                  itemCount: favProducts.length,
                  itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FavproductTile(product: favProducts[index]),
                      ));
            } else if (state is FavProductsFailure) {
              return Center(
                  child: Text('Error fetching fav products ${state.errMsg}'));
            } else {
              return Center(
                  child: Text(
                      'Some un expected state Error  ${state.toString()}'));
            }
          }),
    );
  }
}
