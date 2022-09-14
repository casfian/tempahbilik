import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tempahbilik/login.dart';

class ProfileCheck extends StatelessWidget {
  const ProfileCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Authenticate(),
    ) ;
  }
}

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: const Center(
        child: Text('Profile sini'),
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
      return const Profile(); //dan kita suruh dia gi page Home
    }
    // kalau tak suruh dia login
    return Login();
  }
}
