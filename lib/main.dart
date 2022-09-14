import 'package:flutter/material.dart';
//import 'package:tempahbilik/home.dart';

//tambah ne
import 'package:firebase_core/firebase_core.dart';
import 'package:tempahbilik/authenticate.dart';
import 'package:tempahbilik/authentication.dart';
import 'package:tempahbilik/home.dart';

//utk Authenticate
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:tempahbilik/login.dart';

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
    return MultiProvider(
      providers: [
        Provider<AuthenticationProvider>(
          create: (_) => AuthenticationProvider(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<AuthenticationProvider>().authState,
          initialData: null,
        ),
      ],
      child: MaterialApp(
        title: 'Tempahan Bilik',
        debugShowCheckedModeBanner: false,
        home: Authenticate(
          returnClass: Home(),
        ),
      ),
    );
  }
}

