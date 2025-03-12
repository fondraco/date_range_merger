import 'package:flutter/material.dart';

class TimeRange {
  TimeOfDay startTime;
  TimeOfDay endTime;

  TimeRange({required this.startTime, required this.endTime});

  @override
  String toString() {
    return "Start: ${startTime.toString()} to ${endTime.toString()}";
  }

  @override
  bool operator ==(Object other) {
    if (other is TimeRange) {
      return startTime == other.startTime && endTime == other.endTime;
    }
    return false;
  }

  @override
  int get hashCode => startTime.hashCode ^ endTime.hashCode;
}