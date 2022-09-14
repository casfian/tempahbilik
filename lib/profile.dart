import 'package:flutter/material.dart';
import 'package:tempahbilik/authenticate.dart';


class ProfileCheck extends StatelessWidget {
  const ProfileCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Authenticate(returnClass: Profile()),
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
