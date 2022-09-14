import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tempahbilik/login.dart';

//class ne utk check dia dah login atau tak
class Authenticate extends StatefulWidget {
  const Authenticate({super.key, required this.returnClass});

  final Widget returnClass;

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    // kalau user ada (user bukan kosong aka null) maka maksudnya dah login
    if (firebaseUser != null) {
      return widget.returnClass; //dan kita suruh dia gi page Home
    }
    // kalau tak suruh dia login
    return Login();
  }
}
