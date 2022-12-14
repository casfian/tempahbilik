import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tempahbilik/authenticate.dart';
import 'package:tempahbilik/bilik.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:tempahbilik/tempahan.dart';
import 'package:tempahbilik/tempahandatasource.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield_new.dart';

//authenticate dulu
class DetailCheck extends StatelessWidget {
  const DetailCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return Authenticate(
      returnClass: Details,
    );
  }
}

class Details extends StatefulWidget {
  const Details({super.key, this.passBilik});

  final Bilik? passBilik;

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  //supaya ada gambar kat tempahan saya
  List gambarBilik = [
    'default',
    'bilik_A',
    'bilik_B',
    'bilik_C',
    'bilik_D',
    'bilik_E',
    'bilik_F'
  ];

  String? photobilik;
  //---

  final List<Tempahan> meetings = <Tempahan>[];

  //datasource dari firebase
  TempahanDataSource? events;

  Future<void> getTempahan() async {
    var snapshots = await firestore
        .collection("tempahan")
        .where('status', isEqualTo: 'lulus')
        .where('bilik', isEqualTo: widget.passBilik!.nama)
        .get();

    List<Tempahan> list = snapshots.docs
        .map((e) => Tempahan(
            e.data()['name'],
            DateFormat('yyyy-MM-dd HH:mm').parse(e.data()['mula']),
            DateFormat('yyyy-MM-dd HH:mm').parse(e.data()['tamat']),
            Color(int.parse(e.data()['warna'])),
            e.data()['nobilik'].toString(),
            e.data()['photo'],
            false))
        .toList();
    setState(() {
      events = TempahanDataSource(list);
    });
  }
  //----end firebase datasource

  final tempahannameController = TextEditingController();

  bool isAllDay = false;

  @override
  void initState() {
    super.initState();
    getTempahan();
    setState(() {});
    debugPrint('Bilik Selected: ${widget.passBilik!.nobilik}');
    debugPrint('PhotoBilik --->');
    //Untuk gambar supaya tak null bila add tempahan
    if (widget.passBilik!.nobilik == '1') {
      photobilik = gambarBilik[1];
      debugPrint(photobilik);
    } else if (widget.passBilik!.nobilik == '2') {
      photobilik = gambarBilik[2];
      debugPrint(photobilik);
    } else if (widget.passBilik!.nobilik == '3') {
      photobilik = gambarBilik[3];
      debugPrint(photobilik);
    } else if (widget.passBilik!.nobilik == '4') {
      photobilik = gambarBilik[4];
      debugPrint(photobilik);
    } else if (widget.passBilik!.nobilik == '5') {
      photobilik = gambarBilik[5];
      debugPrint(photobilik);
    } else if (widget.passBilik!.nobilik == '6') {
      photobilik = gambarBilik[6];
      debugPrint(photobilik);
    }
    //---
  }

  @override
  Widget build(BuildContext context) {
    //firebase user
    final firebaseUser = context.watch<User?>();

    debugPrint(firebaseUser!.uid);

    final format = DateFormat("yyyy-MM-dd HH:mm");

    final mulaTempahanController = TextEditingController();
    final tamatTempahanController = TextEditingController();

    var viewtempahan = CalendarView.month;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Image.asset('images/${widget.passBilik!.photo}'),
              Text(widget.passBilik!.nama),
              Text(widget.passBilik!.kapasiti.toString()),

              //Button Tempahan
              ElevatedButton(
                  onPressed: () async {
                    //code utk booking
                    AlertDialog alert = AlertDialog(
                      title: const Text('Borang Tempahan'),

                      //  for Switch to work, wap the content with
                      //  StatefulBuilder(
                      //    builder: (context, StateSetter setState) {
                      //          return widget;
                      //    }
                      //  )

                      content: StatefulBuilder(
                        builder: (context, StateSetter setState) {
                          return SizedBox(
                            width: 250,
                            height: 300,
                            child: Column(
                              children: [
                                TextField(
                                    controller: tempahannameController,
                                    decoration: const InputDecoration(
                                      labelText: 'Tajuk',
                                    )),
                                const SizedBox(
                                  height: 8,
                                ),
                                //startDate & time
                                DateTimeField(
                                  controller: mulaTempahanController,
                                  decoration: const InputDecoration(
                                      labelText: 'Mula',
                                      prefixIcon: Icon(Icons.date_range)),
                                  format: format,
                                  onShowPicker: (context, currentValue) async {
                                    final date = await showDatePicker(
                                        context: context,
                                        firstDate: DateTime(1900),
                                        initialDate:
                                            currentValue ?? DateTime.now(),
                                        lastDate: DateTime(2100));
                                    if (date != null) {
                                      final time = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.fromDateTime(
                                            currentValue ?? DateTime.now()),
                                      );
                                      return DateTimeField.combine(date, time);
                                    } else {
                                      return currentValue;
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 8,
                                ),

                                //endDate & Time
                                DateTimeField(
                                  controller: tamatTempahanController,
                                  decoration: const InputDecoration(
                                      labelText: 'Tamat',
                                      prefixIcon: Icon(Icons.time_to_leave)),
                                  format: format,
                                  onShowPicker: (context, currentValue) async {
                                    final date = await showDatePicker(
                                        context: context,
                                        firstDate: DateTime(1900),
                                        initialDate:
                                            currentValue ?? DateTime.now(),
                                        lastDate: DateTime(2100));
                                    if (date != null) {
                                      final time = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.fromDateTime(
                                            currentValue ?? DateTime.now()),
                                      );
                                      return DateTimeField.combine(date, time);
                                    } else {
                                      return currentValue;
                                    }
                                  },
                                ),

                                Row(
                                  children: [
                                    const Text('Seharian'),
                                    Switch(
                                      value: isAllDay,
                                      onChanged: (value) {
                                        setState(() {
                                          isAllDay = value;
                                          debugPrint(isAllDay.toString());
                                        });
                                      },
                                      activeTrackColor: Colors.lightGreenAccent,
                                      activeColor: Colors.green,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text('Kod Warna bilik: '),
                                    Container(
                                      width: 20,
                                      height: 20,
                                      color: widget.passBilik!.warna,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      actions: [
                        ElevatedButton(
                            onPressed: () async {
                              DateTime startTempahan =
                                  DateFormat('yyyy-MM-dd hh:mm')
                                      .parse(mulaTempahanController.text);
                              DateTime endTempahan =
                                  DateFormat('yyyy-MM-dd hh:mm')
                                      .parse(tamatTempahanController.text);
                              debugPrint(startTempahan.toString());
                              debugPrint(endTempahan.toString());

                              setState(() {
                                meetings.add(Tempahan(
                                    tempahannameController.text,
                                    startTempahan,
                                    endTempahan,
                                    widget.passBilik!.warna!,
                                    photobilik,
                                    widget.passBilik!.nobilik,
                                    isAllDay));
                              });

                              //Next
                              //code hantar ke Firebase pulak
                              //code
                              //boleh Add Tempahan ke Firebase
                              try {
                                //code
                                await firestore
                                    .collection('tempahan')
                                    .doc()
                                    .set({
                                  'name': tempahannameController.text,
                                  'mula': mulaTempahanController.text,
                                  'tamat': tamatTempahanController.text,
                                  'bilik': widget.passBilik!.nama,
                                  'noBilik': widget.passBilik!.nobilik,
                                  'warna':
                                      widget.passBilik!.warna!.value.toString(),
                                  'status': 'baru',
                                  'photo': photobilik,
                                  'uid': firebaseUser.uid,
                                }).then((value) => Navigator.pop(context));
                                debugPrint('Add tempahan data to Firebase');
                              } catch (e) {
                                debugPrint(e.toString());
                              }
                              //---
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

              //end button Tempahan

              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Tempahan Bulanan',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                      onPressed: () {
                        //refresh
                        getTempahan();
                        setState(() {
                          //refresh
                        });
                      },
                      icon: const Icon(Icons.refresh))
                ],
              ),

              SizedBox(
                height: 400,
                child: SfCalendar(
                  view: viewtempahan,
                  //dataSource: TempahanDataSource(_getDataSource()),
                  dataSource: events,
                  monthViewSettings: const MonthViewSettings(
                    showAgenda: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
