import 'package:flutter/material.dart';
import 'package:week1/pages/home.dart';


void main() {
  runApp(const Mystore());
}

class Mystore extends StatelessWidget {
  const Mystore({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
            debugShowCheckedModeBanner: false,

      home:HomeScreen()
      
    );
  }
}
