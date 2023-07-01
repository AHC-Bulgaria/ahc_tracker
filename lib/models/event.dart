import 'dart:convert';
import 'dart:math';

import 'package:ahc_tracker/services/db_service.dart';
import 'package:ahc_tracker/utils/formaters.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

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
  int? id;
  late final EventSeverity severity;
  late final DateTime date;
  Map<dynamic, dynamic>? metadata = {};

  Event({
    required this.severity,
    required this.date,
  });

  Event.fromRow(Map<String, dynamic> data) {
    id = data['id'];
    severity = EventSeverity.values[data['severity']];
    date = DateTime.parse('${data["date"]} 00:00:00.000Z');
    try {
      metadata = json.decode(data['metadata']);
    } catch (_) {
      metadata = {};
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': dateToDB.format(date),
      'severity': severity.index,
      'metadata': json.encode(metadata),
    };
  }

  Future<void> save() async {
    if (id != null) {
      await (await db)
          .update('Events', toMap(), where: 'id = ?', whereArgs: [id]);
    } else {
      await (await db).insert(
        'Events',
        toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  static Future<Event> fromDate(DateTime date) async {
    final result = (await (await db).rawQuery(
      'SELECT * FROM Events WHERE date=?',
      [dateToDB.format(date)],
    ))
        .first;

    return Event.fromRow(result);
  }

  static fromDateRange(DateTime start, DateTime end) async {
    final results = (await (await db).rawQuery(
      'SELECT * FROM Events WHERE date BETWEEN ? AND ?',
      [dateToDB.format(start), dateToDB.format(end)],
    ));

    return {
      for (final result in results)
        DateTime.parse('${result["date"]} 00:00:00.000Z'): Event.fromRow(result)
    };
  }
}

EventSeverity generateRandomSeverity({int? i}) {
  var rnd = Random();
  return EventSeverity.values[i != null
      ? i % EventSeverity.values.length
      : rnd.nextInt(EventSeverity.values.length)];
}
