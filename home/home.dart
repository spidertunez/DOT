import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: Colors.blueAccent,
      ),
      body: const Center(
        child: Text("Welcome!", style: TextStyle(fontSize: 24, color: Colors.white)),
      ),
    );
  }
}
