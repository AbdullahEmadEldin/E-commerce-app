import 'package:e_commerce_app/business_logic_layer/auth_cubit/auth_cubit.dart';
import 'package:e_commerce_app/view/Widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LogOut) {
          Navigator.pop(context);
        }
      },
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: MainButton(
            text: 'Log Out',
            ontap: () {
              BlocProvider.of<AuthCubit>(context).logOut();
            },
          ),
        ),
      ),
    );
  }
}
