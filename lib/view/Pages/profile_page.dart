import 'package:e_commerce_app/Controllers/auth_controller.dart';
import 'package:e_commerce_app/view/Widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthController>(
      builder: (_, value, __) => Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child:
              MainButton(text: 'Log Out', ontap: () => _logOut(value, context)),
        ),
      ),
    );
  }

  Future<void> _logOut(AuthController value, BuildContext context) async {
    try {
      await value.logOut();
      Navigator.pop(context);
    } catch (e) {
      debugPrint('logout error: $e');
    }
  }
}
