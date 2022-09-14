import 'package:flutter/material.dart';
//import 'package:tempahbilik/home.dart';

//tambah ne
import 'package:firebase_core/firebase_core.dart';
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
      child: const MaterialApp(
        title: 'Tempahan Bilik',
        debugShowCheckedModeBanner: false,
        home: Home(),
      ),
    );
  }
}

//class ne utk check dia dah login atau tak
class Authenticate extends StatelessWidget {
   const Authenticate({super.key});

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    // kalau user ada (user bukan kosong aka null) maka maksudnya dah login
    if (firebaseUser != null) {
      return Home(); //dan kita suruh dia gi page Home
    }
    // kalau tak suruh dia login
    return Login();
  }
}
