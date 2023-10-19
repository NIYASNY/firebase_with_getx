import 'package:firebase_with_getx_todo/app/utils/constants.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';

int getDateTimestamp(DateTime dateTime) {
  return DateTime(dateTime.year, dateTime.month, dateTime.day)
      .millisecondsSinceEpoch;
}

String getFormattedDate(int timestamp) {
  final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  return DateFormat('MMM d yyyy').format(date);
}

Color getLabelColor(int timestamp) {
  final date = DateTime.fromMillisecondsSinceEpoch(timestamp);

  return labelColors[date.weekday % labelColors.length];
}