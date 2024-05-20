import 'package:flutter/material.dart';
import 'package:week1/pages/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';



void main () async 
{
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
