import 'package:e_commerce_app/Utilities/assets.dart';
import 'package:e_commerce_app/Utilities/routes.dart';
import 'package:e_commerce_app/business_logic_layer/auth_cubit/auth_cubit.dart';
import 'package:e_commerce_app/business_logic_layer/user_preferences_cubit/user_perferences_cubit.dart';
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
    final size = MediaQuery.of(context).size;
    BlocProvider.of<UserPrefCubit>(context).getUserData();
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
              SizedBox(height: size.height * 0.02),
              _profileInfoDrawer(context, size),
              SizedBox(height: size.height * 0.03),
              _optionTile(context,
                  title: 'My orders',
                  subtitle: 'no orders yet',
                  routeName: AppRoutes.ordersPage),
              _optionTile(
                context,
                title: 'Shipping addresses',
                subtitle: '3 address',
                routeName: AppRoutes.viewAddressesPage,
              ),
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
                  routeName: AppRoutes.settingsPage),
              SizedBox(height: size.height * 0.24),
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
                        BlocProvider.of<AuthCubit>(context).googleSignOut();
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
      required String routeName,
      Object? arguments}) {
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
            IconButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true)
                      .pushNamed(routeName, arguments: arguments);
                },
                icon: const Icon(Icons.arrow_right))
          ],
        ),
        const Divider(
          thickness: 0.3,
          color: Colors.black,
        ),
      ],
    );
  }

  Row _profileInfoDrawer(BuildContext context, Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(
          child: Image.asset(
            AppAssets.profilePic,
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(width: size.width * 0.02),
        BlocBuilder<UserPrefCubit, UserPrefState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state is UserDataSucessfull
                      ? state.user.name
                      : 'error fetching name ${state.toString()}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Colors.black),
                ),
                Text(
                  state is UserDataSucessfull
                      ? state.user.email
                      : 'error fetching emial ${state.toString()}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.black26),
                )
              ],
            );
          },
        ),
      ],
    );
  }
}
