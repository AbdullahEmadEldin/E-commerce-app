import 'package:e_commerce_app/business_logic_layer/product_cubit/product_cubit.dart';
import 'package:e_commerce_app/data_layer/Models/product.dart';
import 'package:e_commerce_app/view/Widgets/category_option.dart';
import 'package:e_commerce_app/view/Widgets/product_tile_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  int isActiveIndex = 0;
  List<String> options = ['Women', 'Man', 'Kids'];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 50, child: _paymentOptionList()),
              isActiveIndex == 0
                  ? SizedBox(
                      height: size.height - 100,
                      child: _productsBlocBuilder(size,
                          emptyMsg: 'No women products', isWomenCategory: true),
                    )
                  : const SizedBox(),
              isActiveIndex == 1
                  ? SizedBox(
                      height: size.height - 100,
                      child: _productsBlocBuilder(size,
                          emptyMsg: 'No men products', isWomenCategory: false))
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  BlocBuilder<ProductCubit, ProductState> _productsBlocBuilder(Size size,
      {required String emptyMsg, required bool isWomenCategory}) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SuccessfullyProductsLoaded) {
          final List<Product> products;
          isWomenCategory
              ? products = state.womenProducts
              : products = state.menProducts;
          if (products.isEmpty) {
            return const Center(child: Text('No Women Products'));
          }
          return GridView.builder(
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 0.7),
              itemCount: products.length,
              itemBuilder: (_, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ProductTileHome(
                      product: products[index],
                      isNew: products[index].discount == 0,
                      postions: (
                        favButtonBottomPostion: size.width * 0.15,
                        favButtonRightPostion: size.width * 0.0000001,
                        productDetailsBottom: size.height * 0.00001,
                        imageHeight: 180
                      ),
                    ),
                  ));
        } else if (state is ProductsFailure) {
          return Center(child: Text('Error: ${state.errorMsg}'));
        } else {
          BlocProvider.of<ProductCubit>(context).retrieveAllProducts();

          return Center(child: Text('Some fucking state: ${state.toString()}'));
        }
      },
    );
  }

  ListView _paymentOptionList() {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: options.length,
      itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            isActiveIndex = index;
            setState(() {});
          },
          child: CategoryOption(
            category: options[index],
            isSelected: isActiveIndex == index,
          )),
    );
  }
}
