import 'package:flutter/material.dart';
import 'package:week1/pages/home.dart';
import 'package:firebase_core/firebase_core.dart';



void main () async 
{
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
