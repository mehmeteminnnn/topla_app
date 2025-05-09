import 'package:flutter/material.dart';

class ReservationScreen extends StatelessWidget {
  const ReservationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rezervasyon'),
      ),
      body: const Center(
        child: Text(
          'Rezervasyon',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
