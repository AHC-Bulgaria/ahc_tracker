import 'package:ahc_tracker/screens/manage_event.dart';
import 'package:ahc_tracker/widgets/events_calendar.dart';
import 'package:ahc_tracker/widgets/events_card.dart';
import 'package:flutter/material.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AHC Tracker'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => const ManageEvent(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: ListView(
        padding: const EdgeInsets.all(4),
        children: [
          EventsCard(
            image: Image.asset('assets/images/calendar.jpg'),
            title: 'Month',
            subtitle: 'Events Calendar',
            child: const EventsCalendar(),
          ),
          EventsCard(
            image: Image.asset('assets/images/calendar2.jpg'),
            title: 'Monthly Summary',
            subtitle: 'Month',
            child: const Text(''),
          ),
        ],
      ),
    );
  }
}
