import 'package:flutter/material.dart';

class Tempahan {
  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  String? nobilik;
  String? photo;
  bool isAllDay;

  //constructor
  Tempahan(this.eventName, this.from, this.to, this.background, this.photo, this.nobilik,   this.isAllDay);
}
