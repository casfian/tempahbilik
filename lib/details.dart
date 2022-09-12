import 'package:flutter/material.dart';
import 'package:tempahbilik/bilik.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:tempahbilik/tempahan.dart';
import 'package:tempahbilik/tempahandatasource.dart';

class Details extends StatefulWidget {
  const Details({super.key, required this.passBilik});

  final Bilik passBilik;

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final List<Tempahan> meetings = <Tempahan>[];

  //tempahan
  //------------------------------------------
  List<Tempahan> _getDataSource() {
    
    final DateTime today = DateTime.now();
    final DateTime startTime =
        DateTime(today.year, today.month, today.day, 9, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 2));

    print(startTime);
    print(endTime);

    meetings.add(Tempahan(
        'Conference', startTime, endTime, const Color(0xFF0F8644), false));
    return meetings;
  }
  //------------------------------------------
  //end tempahan

  final tempahannameController = TextEditingController();

  // final DateTime today2 = DateTime.now();
  //   final DateTime startTempahan =
  //       DateTime(today2.year, today2.month, today2.day, 9, 0, 0);
  //   final DateTime endTempahan = startTempahan.add(const Duration(hours: 2));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Image.asset('images/${widget.passBilik.photo}'),
              Text(widget.passBilik.nama),
              Text(widget.passBilik.kapasiti.toString()),
              ElevatedButton(
                  onPressed: () async {
                    //code utk booking
                    AlertDialog alert = AlertDialog(
                      title: const Text('Borang Tempahan'),
                      content: SizedBox(
                        width: 200,
                        height: 200,
                        child: Column(
                          children: [
                            TextField(
                              controller: tempahannameController,
                            ),
                            TextField(),
                            TextField(),
                          ],
                        ),
                      ),
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              //code
                              //boleh Add Tempahan ke Firebase
                              // try {
                              //   //code
                              //   await firestore.collection('tempahan').doc().set({
                              //     'name': widget.passBilik.nama,
                              //     'kapasiti': widget.passBilik.kapasiti.toString(),
                              //     'status': 'baru',
                              //   });
                              //   debugPrint('Add tempahan data to Firebase');
                              // } catch (e) {
                              //   debugPrint(e.toString());
                              // }
                              //---

                              DateTime startTempahan = DateTime(2022, 09, 15, 9, 0, 0);
                              DateTime endTempahan = DateTime(2022, 09, 15, 18, 0, 0);

                              meetings.add(Tempahan(
                                  tempahannameController.text,
                                  startTempahan,
                                  endTempahan,
                                  const Color(0xFF0F8644),
                                  false));
                                  setState(() {
                                    
                                  });
                              Navigator.pop(context);
                            },
                            child: const Text('OK')),
                        ElevatedButton(
                            onPressed: () {
                              //code
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel')),
                      ],
                    );

                    showDialog(
                        context: context,
                        builder: (context) {
                          return alert;
                        });
                  },
                  child: const Text('Buat Tempahan utk Bilik Ini')),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Tempahan Minggu ini: ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SfCalendar(
                view: CalendarView.week,
                dataSource: TempahanDataSource(_getDataSource()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
