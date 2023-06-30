import 'dart:math';

import 'package:flutter/material.dart';

enum EventSeverity {
  low(level: 1, color: Colors.green),
  neutral(level: 1, color: Colors.lime),
  medium(level: 1, color: Colors.yellow),
  high(level: 1, color: Colors.orange),
  nightmare(level: 1, color: Colors.red);

  final int level;
  final Color color;

  const EventSeverity({
      required this.level,
      required this.color,
  });
}

class Event {
  final EventSeverity severity;
  final DateTime date;

  const Event({required this.severity, required this.date});
}

EventSeverity generateRandomSeverity({int? i}) {
  var rnd = Random();
  return EventSeverity.values[i != null ? i % EventSeverity.values.length : rnd.nextInt(EventSeverity.values.length)];
}
