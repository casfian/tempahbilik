import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TestFirebaseDemo extends StatelessWidget {
  TestFirebaseDemo({super.key});

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Firebase Demo'),
      ),
      body: Center(
        child: Column(
          children: [
            const Text('Hello Firebase'),
            ElevatedButton(
                onPressed: () async {
                  //code
                  try {
                    //code
                    await firestore
                        .collection('fruits')
                        .doc()
                        .set({'name': 'apple', 'color': 'red'});
                    debugPrint('Add data to Firebase');
                  } catch (e) {
                    debugPrint(e.toString());
                  }
                  //---
                },
                child: const Text('Add firebase data'))
          ],
        ),
      ),
    );
  }
}
