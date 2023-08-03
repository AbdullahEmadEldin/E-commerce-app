import 'package:e_commerce_app/Views/Widgets/main_button.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 40,
            horizontal: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Login',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 80),
              TextFormField(
                controller: _emailController,
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
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your password' : null,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                ),
              ),
              const SizedBox(height: 8.0),
              Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {},
                    child: Text('Forgot your password? '),
                  )),
              SizedBox(height: 16),
              MainButton(text: 'LOGIN', ontap: () {}),
              SizedBox(height: 8.0),
              Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {},
                    child: Text('Don\'t have an account? Register '),
                  )),
              const Spacer(flex: 1),
              Center(child: const Text('Or Login with')),
              SizedBox(height: 16.0),
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
      )),
    );
  }
}
