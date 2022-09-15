import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TempahanSaya extends StatefulWidget {
  const TempahanSaya({super.key});

  @override
  State<TempahanSaya> createState() => _TempahanSayaState();
}

class _TempahanSayaState extends State<TempahanSaya> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final List<String> options = <String>[
    'Batal'
  ]; //ne biarkan mana tau ada options lain nanti

  final format = DateFormat("yyyy-MM-dd HH:mm");

  final tempahannameController = TextEditingController();
  final mulaTempahanController = TextEditingController();
  final tamatTempahanController = TextEditingController();

  bool isAllDay = false;

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tempahan Saya'),
      ),
      body: FutureBuilder(
          future: firestore
              .collection('tempahan')
              .where('uid', isEqualTo: firebaseUser!.uid)
              .get(),
          builder: (context, snapshot) {
            //check error here
            if (snapshot.hasError) {
              return const Center(child: Text('Error'));
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            //---

            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(
                      leading:
                          Image.asset('images/${data['photo'].toString()}.jpg'),
                      //leading: Text(data['photo'].toString()),
                      title: Text(data['name'].toString()),
                      subtitle: Text('Status: ${data['status']},\n${data['mula']} hingga ${data['tamat']}'),
                      trailing: PopupMenuButton<String>(
                        icon: const Icon(Icons.settings),
                        itemBuilder: (BuildContext context) =>
                            options.map((String choice) {
                          return PopupMenuItem<String>(
                            value: choice,
                            child: Text(choice),
                          );
                        }).toList(),
                        onSelected: (String value) {
                          if (value == "Batal") {
                            debugPrint(document.id);
                            try {
                              firestore
                                  .collection('tempahan')
                                  .doc(document.id)
                                  .delete();
                              setState(() {
                                //update screen
                              });
                            } catch (e) {
                              debugPrint(e.toString());
                            }
                          } else {
                            debugPrint('Others here');
                          }
                        },
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          }),
    );
  }
}
