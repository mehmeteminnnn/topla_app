import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ana Ekran'),
      ),
      body: const Center(
        child: Text(
          'Ana Ekran',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
