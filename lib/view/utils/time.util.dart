import 'package:flutter/material.dart';

Text dateTimeWidget(DateTime day, TimeOfDay time) =>
    Text('on ${day.day}/${day.month}/${day.year} ${time.hour}:${time.minute}');
