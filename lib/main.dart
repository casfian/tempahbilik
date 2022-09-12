import 'package:flutter/material.dart';
//import 'package:tempahbilik/home.dart';

//tambah ne
import 'package:firebase_core/firebase_core.dart';
import 'package:tempahbilik/home.dart';
import 'package:tempahbilik/testcalendardemo.dart';

void main() async {
  //tambah ne
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //---

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}