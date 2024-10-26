import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/auth_bloc.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isPhoneLogin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocProvider(
          create: (context) => AuthBloc(),
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthAuthenticated) {
                Navigator.pushReplacementNamed(context, '/car-list');
              } else if (state is AuthError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SwitchListTile(
                        title: Text(isPhoneLogin
                            ? 'Login with Phone'
                            : 'Login with Email'),
                        value: isPhoneLogin,
                        onChanged: (value) {
                          setState(() {
                            isPhoneLogin = value;
                          });
                        },
                      ),
                      TextFormField(
                        controller:
                            isPhoneLogin ? _phoneController : _emailController,
                        decoration: InputDecoration(
                          labelText: isPhoneLogin ? 'Phone' : 'Email',
                          border: OutlineInputBorder(),
                          prefixIcon:
                              Icon(isPhoneLogin ? Icons.phone : Icons.email),
                        ),
                        validator:
                            isPhoneLogin ? _validatePhone : _validateEmail,
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.lock),
                        ),
                        obscureText: true,
                        validator: _validatePassword,
                      ),
                      SizedBox(height: 20),
                      state is AuthLoading
                          ? CircularProgressIndicator()
                          : ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  final authBloc =
                                      BlocProvider.of<AuthBloc>(context);
                                  authBloc.add(
                                    LoginEvent(
                                      isPhoneLogin
                                          ? _phoneController.text
                                          : _emailController.text,
                                      _passwordController.text,
                                      isPhoneLogin,
                                    ),
                                  );
                                }
                              },
                              child: Text('Login'),
                            ),
                      const SizedBox(height: 20),
                      // Add Register Link
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context,
                              '/register'); // Navigate to Register Page
                        },
                        child: const Text('Don\'t have an account? Register here!'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
      return 'Please enter a valid 10-digit phone number';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }
}
