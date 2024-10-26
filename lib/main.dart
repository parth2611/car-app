import 'package:car_app/presentation/pages/login.dart';
import 'package:car_app/presentation/pages/register.dart';
import 'package:flutter/material.dart';
import 'package:car_app/presentation/pages/car_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Car App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: const HomeScreen(),
      //home: LoginPage(),
      // Define your routes here
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/car-list': (context) => CarListPage(),  // Add this route
        '/register': (context) => RegisterPage(), 
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Car App'),
      ),
      body: const Center(
        child: Text('Welcome to the Car App!'),
      ),
    );
  }
}
