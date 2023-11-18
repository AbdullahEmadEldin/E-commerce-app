import 'package:e_commerce_app/business_logic_layer/user_preferences_cubit/user_perferences_cubit.dart';
import 'package:e_commerce_app/view/Widgets/order_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderPages extends StatelessWidget {
  const OrderPages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    BlocProvider.of<UserPrefCubit>(context).getOrders();
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My Orders',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: size.height * 0.02),
                BlocBuilder<UserPrefCubit, UserPrefState>(
                  builder: (context, state) {
                    if (state is OrdersLoading) {
                      return const CircularProgressIndicator();
                    } else if (state is OrdersSucessful) {
                      final orders = state.orders;

                      if (orders.isEmpty) {
                        return const Center(
                            child: Text('You haven\'nt make any orders yet'));
                      } else {
                        return SizedBox(
                          height: size.height * 0.85,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: orders.length,
                              itemBuilder: (context, index) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: OrderTile(
                                        order: orders[index],
                                        orderNumber: index + 1),
                                  )),
                        );
                      }
                    } else if (state is OrdersFailure) {
                      return Center(child: Text('Erorr: ${state.errorMsg}'));
                    }
                    return Center(
                        child: Text('Some State ${state.toString()}'));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
