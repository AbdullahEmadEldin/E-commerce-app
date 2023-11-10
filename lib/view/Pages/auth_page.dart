// ignore_for_file: curly_braces_in_flow_control_structures
import 'package:e_commerce_app/Utilities/assets.dart';
import 'package:e_commerce_app/business_logic_layer/auth_cubit/auth_cubit.dart';
import 'package:e_commerce_app/view/Widgets/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'package:e_commerce_app/view/Widgets/main_button.dart';
import '../../Utilities/enums.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordFocusNode = FocusNode();
  bool isLoading = false;
  AuthFormType authFormType = AuthFormType.login;
  @override
  //dispose method release the memory resources used by objects or controllers
  //when they no lnoger needed to avoid memory leak
  ///I removed controller becuase there was inteferance between them and formkey.clear

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final authOptions = BlocProvider.of<AuthCubit>(context);
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          isLoading = true;
        } else if (state is SuccessfulAuth) {
          //! authentication tip:
          //when you submit it goes directly to the bottomNavBar without Navigation hooooooow?
          //because the landinPage mediator and have StramBuilder
          // StreamBuilder is a widget that builds itself based on the latest snapshot of interaction with a stream
          //So, when you submit, the snapshot.data is updated with the correct user ans password and then logIn...
          isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Successful authentication'),
            ),
          );
        } else if (state is FailureAuth) {
          isLoading = false;
          MainDialog(
                  context: context,
                  title: 'Error',
                  content: state.errorMsg.toString())
              .showAlertDialog();
        } else if (state is FormTypeToggled) {
          authFormType = state.formType;
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            body: SafeArea(
                child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: authFormType == AuthFormType.register ? 10 : 25,
                  horizontal: 30,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        authFormType == AuthFormType.login
                            ? 'Login'
                            : 'Register',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 80),
                      TextFormField(
                        //this function make the done button on soft keyboard go to the textFeild of _passwordFocusNode
                        onEditingComplete: () => FocusScope.of(context)
                            .requestFocus(_passwordFocusNode),
                        validator: (value) =>
                            value!.isEmpty ? 'Please enter your email' : null,
                        onChanged: authOptions.updateEmail,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          hintText: 'Enter your email',
                        ),
                      ),
                      authFormType == AuthFormType.register
                          ? const SizedBox(height: 16)
                          : const SizedBox(),
                      authFormType == AuthFormType.register
                          ? TextFormField(
                              onEditingComplete: () => FocusScope.of(context)
                                  .requestFocus(_passwordFocusNode),
                              validator: (value) => value!.isEmpty
                                  ? 'Please enter your name'
                                  : null,
                              onChanged: authOptions.updateName,
                              decoration: const InputDecoration(
                                labelText: 'Name',
                                hintText: 'Enter your name',
                              ),
                            )
                          : const SizedBox(),
                      const SizedBox(height: 16),
                      TextFormField(
                        obscureText: true,
                        focusNode: _passwordFocusNode,
                        validator: (value) => value!.isEmpty
                            ? 'Please enter your password'
                            : null,
                        onChanged: authOptions.updatePassword,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          hintText: 'Enter your password',
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      if (authFormType == AuthFormType.login)
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                              onTap: () {},
                              child: const Text('Forgot your password? ')),
                        ),
                      const SizedBox(height: 16),
                      MainButton(
                          text: authFormType == AuthFormType.login
                              ? 'LOGIN'
                              : 'REGISTER',
                          ontap: () async {
                            //this if state check the validator condtion of textfields
                            if (_formKey.currentState!.validate()) {
                              authOptions.submit();
                            }
                          }),
                      const SizedBox(height: 8.0),
                      Align(
                          alignment: Alignment.center,
                          child: InkWell(
                            onTap: () {
                              //the currentState method doesn't work and i don't know the reason
                              //WHY ? it doesn't work when there is a controller so I deleted both controllers
                              _formKey.currentState!.reset();
                              authOptions.toggleFormType();
                            },
                            child: authFormType == AuthFormType.login
                                ? const Text(
                                    'Don\'t have an account? Register ')
                                : const Text('Already have an account? Login'),
                          )),
                      SizedBox(height: size.height * 0.15),
                      Center(
                          child: authFormType == AuthFormType.login
                              ? const Text('Or Login with')
                              : const Text('Or Sign up with')),
                      const SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _loginOption(
                              logo: AppAssets.facebooklogo,
                              ontap: () {
                                authOptions.signInWithFacebook();
                              }),
                          const SizedBox(width: 16.0),
                          _loginOption(
                              logo: AppAssets.googleLogo,
                              ontap: () {
                                authOptions.signInwithGoogle();
                              }),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )),
          ),
        );
      },
    );
  }

  Widget _loginOption({required String logo, required Function ontap}) {
    return Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: Colors.white,
        ),
        child: InkWell(
          onTap: () {
            ontap();
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(
              logo,
            ),
          ),
        ));
  }
}
