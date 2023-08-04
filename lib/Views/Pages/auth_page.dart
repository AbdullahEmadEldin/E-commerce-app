// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:e_commerce_app/Utilities/routes.dart';
import 'package:e_commerce_app/Views/Widgets/main_button.dart';
import 'package:flutter/material.dart';

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
  var _authType = AuthFormType.login;
  final _passwordFocusNode = FocusNode();
  @override
  //dispose method release the memory resources used by objects or controllers
  //when they no lnoger needed
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
                  _authType == AuthFormType.login ? 'Login' : 'Register',
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
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your email',
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  focusNode: _passwordFocusNode,
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter your password' : null,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                  ),
                ),
                const SizedBox(height: 8.0),
                if (_authType == AuthFormType.login)
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                        onTap: () {},
                        child: const Text('Forgot your password? ')),
                  ),
                const SizedBox(height: 16),
                MainButton(
                    text:
                        _authType == AuthFormType.login ? 'LOGIN' : 'REGISTER',
                    ontap: () {
                      if (_formKey.currentState!.validate())
                        Navigator.pushNamed(context, AppRoutes.bottomBar);
                    }),
                SizedBox(height: 8.0),
                Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        _formKey.currentState!.reset();
                        setState(() {
                          if (_authType == AuthFormType.login)
                            _authType = AuthFormType.register;
                          else
                            _authType = AuthFormType.login;
                        });
                      },
                      child: _authType == AuthFormType.login
                          ? const Text('Don\'t have an account? Register ')
                          : const Text('Already have an account? Login'),
                    )),
                SizedBox(height: size.height * 0.14),
                Center(
                    child: _authType == AuthFormType.login
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
  }
}
