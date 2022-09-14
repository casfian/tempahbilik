import 'package:flutter/material.dart';
import 'package:tempahbilik/bilik.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:tempahbilik/tempahan.dart';
import 'package:tempahbilik/tempahandatasource.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield_new.dart';

//authenticate dulu

class Details extends StatefulWidget {
  const Details({super.key, this.passBilik});

  final Bilik? passBilik;

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final List<Tempahan> meetings = <Tempahan>[];

  //tempahan
  //------------------------------------------
  List<Tempahan> _getDataSource() {
    //if you want initial data in calendar, can use this:
    // final DateTime today = DateTime.now();
    // final DateTime startTime =
    //     DateTime(today.year, today.month, today.day, 9, 0, 0);
    // final DateTime endTime = startTime.add(const Duration(hours: 2));

    // meetings.add(Tempahan(
    //     'Conference', startTime, endTime, const Color(0xFF0F8644), false));

    return meetings;
  }
  //------------------------------------------
  //end tempahan

  final tempahannameController = TextEditingController();

  bool isAllDay = false;

  // final DateTime today2 = DateTime.now();
  //   final DateTime startTempahan =
  //       DateTime(today2.year, today2.month, today2.day, 9, 0, 0);
  //   final DateTime endTempahan = startTempahan.add(const Duration(hours: 2));

  @override
  Widget build(BuildContext context) {
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
                                  'warna':
                                      widget.passBilik!.warna!.value.toString(),
                                  'status': 'baru',
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
              const Text(
                'Tempahan Month ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              SizedBox(
                height: 400,
                child: SfCalendar(
                  view: viewtempahan,
                  dataSource: TempahanDataSource(_getDataSource()),
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
