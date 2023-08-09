// ignore_for_file: curly_braces_in_flow_control_structures
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:e_commerce_app/Controllers/auth_controller.dart';
import 'package:e_commerce_app/Views/Widgets/main_button.dart';
import '../../Utilities/enums.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordFocusNode = FocusNode();

  @override
  //dispose method release the memory resources used by objects or controllers
  //when they no lnoger needed to avoid memory leak
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Consumer<AuthController>(builder: (context, authModel, child) {
      return Scaffold(
        body: SafeArea(
            child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 40,
              horizontal: 30,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    authModel.authFormType == AuthFormType.login
                        ? 'Login'
                        : 'Register',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 80),
                  TextFormField(
                    controller: _emailController,
                    //this function make the done button on soft keyboard go to the textFeild of _passwordFocusNode
                    onEditingComplete: () =>
                        FocusScope.of(context).requestFocus(_passwordFocusNode),
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter your email' : null,
                    onChanged: authModel.updateEmail,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter your email',
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    obscureText: true,
                    controller: _passwordController,
                    focusNode: _passwordFocusNode,
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter your password' : null,
                    onChanged: authModel.updatePassword,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter your password',
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  if (authModel.authFormType == AuthFormType.login)
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                          onTap: () {},
                          child: const Text('Forgot your password? ')),
                    ),
                  const SizedBox(height: 16),
                  MainButton(
                      text: authModel.authFormType == AuthFormType.login
                          ? 'LOGIN'
                          : 'REGISTER',
                      ontap: () async {
                        //this if state check the validator condtion of textfields
                        if (_formKey.currentState!.validate()) {
                          _submit(authModel);
                        }
                      }),
                  const SizedBox(height: 8.0),
                  Align(
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () {
                          //TODO: the currentState method doesn't work and i don't know the reason
                          _formKey.currentState!.reset();
                          authModel.toggleFormType();
                        },
                        child: authModel.authFormType == AuthFormType.login
                            ? const Text('Don\'t have an account? Register ')
                            : const Text('Already have an account? Login'),
                      )),
                  SizedBox(height: size.height * 0.14),
                  Center(
                      child: authModel.authFormType == AuthFormType.login
                          ? const Text('Or Login with')
                          : const Text('Or Sign up with')),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          color: Colors.white,
                        ),
                        child: Icon(Icons.add),
                      ),
                      const SizedBox(width: 16.0),
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          color: Colors.white,
                        ),
                        child: Icon(Icons.add),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        )),
      );
    });
  }

  /// Helper functions
  Future<void> _submit(AuthController auth) async {
    try {
      //TODO: authentication tip:
      //when you submit it goes directly to the bottomNavBar without Navigation hooooooow?
      //because the landinPage mediator and have StramBuilder
      // StreamBuilder is a widget that builds itself based on the latest snapshot of interaction with a stream
      //So, when you submit the snapshot.data is updated with the correct user ans password and then logIn...
      await auth.submit();
    } catch (e) {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: Text(
                  'Error!',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                content: Text(e.toString(),
                    style: Theme.of(context).textTheme.titleMedium),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('Ok'))
                ],
              ));
    }
  }
}
