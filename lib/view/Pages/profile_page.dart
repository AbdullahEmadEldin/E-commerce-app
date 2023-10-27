import 'package:e_commerce_app/Utilities/assets.dart';
import 'package:e_commerce_app/business_logic_layer/auth_cubit/auth_cubit.dart';
import 'package:e_commerce_app/view/Widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My profile',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _profileInfoDrawer(context),
              const SizedBox(height: 24),
              _optionTile(context,
                  title: 'My orders',
                  subtitle: 'no orders yet',
                  routeName: 'orders'),
              _optionTile(context,
                  title: 'Shipping addresses',
                  subtitle: '3 address',
                  routeName: 'address'),
              _optionTile(context,
                  title: 'Payment methods',
                  subtitle: 'visa **34',
                  routeName: 'routeName'),
              _optionTile(context,
                  title: 'My reviews',
                  subtitle: 'subtitle',
                  routeName: 'routeName'),
              _optionTile(context,
                  title: 'Settings',
                  subtitle: 'Passwords, Notifications',
                  routeName: 'routeName'),
              const SizedBox(height: 56),
              BlocListener<AuthCubit, AuthState>(
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
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _optionTile(BuildContext context,
      {required String title,
      required String subtitle,
      required String routeName}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Colors.black),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.black26),
                ),
              ],
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_right))
          ],
        ),
        const Divider(
          thickness: 0.3,
          color: Colors.black,
        ),
      ],
    );
  }

  Row _profileInfoDrawer(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(
          child: Image.asset(AppAssets.profilePic),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //TODO: fetching personal info from firebase (User model)
            Text(
              'Abdullah Emad',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Colors.black),
            ),
            Text(
              'email@email.com',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.black26),
            )
          ],
        )
      ],
    );
  }
}
