import 'package:flutter/material.dart';
import '../../data/mock_data.dart';
import '../widgets/car_card.dart';

class CarListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Available Cars')),
      body: ListView.builder(
        itemCount: cars.length,
        itemBuilder: (context, index) {
          final car = cars[index];
          return CarCard(car: car);
        },
      ),
    );
  }
}
