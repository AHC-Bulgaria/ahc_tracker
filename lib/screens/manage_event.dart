import 'package:ahc_tracker/models/event.dart';
import 'package:ahc_tracker/utils/formaters.dart';
import 'package:flutter/material.dart';

class ManageEvent extends StatefulWidget {
  const ManageEvent({super.key});

  @override
  State<ManageEvent> createState() => _ManageEvent();
}

class _ManageEvent extends State<ManageEvent> {
  double _value = 0;
  DateTime _date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    Color sliderColor = EventSeverity.values[_value.toInt()].color;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Log'),
      ),
      persistentFooterButtons: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton.icon(
          icon: const Icon(Icons.save_outlined),
          label: const Text('Save'),
          onPressed: () async {
            Event(date: _date, severity: EventSeverity.values[_value.toInt()])
                .save();
            Navigator.of(context).pop();
          },
        ),
      ],
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Date selection
            ListTile(
              title: Text(dateReadble.format(_date)),
              subtitle: const Text('Date'),
              leading: const Icon(Icons.today),
              trailing: IconButton(
                icon: const Icon(Icons.edit_outlined),
                onPressed: () async {
                  final gotDate = await showDatePicker(
                    context: context,
                    initialDate: _date,
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (gotDate != null) {
                    setState(() {
                      _date = gotDate;
                    });
                  }
                },
              ),
            ),
            const SizedBox(
              height: 16,
            ),

            // Severity
            Text(
              'Severity',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.sentiment_satisfied_outlined,
                    color: EventSeverity.low.color,
                  ),
                  Icon(
                    Icons.sentiment_neutral_outlined,
                    color: EventSeverity.medium.color,
                  ),
                  Icon(Icons.sentiment_dissatisfied_outlined,
                      color: EventSeverity.nightmare.color),
                ],
              ),
            ),
            Slider(
              divisions: 4,
              value: _value,
              min: 0,
              max: 4,
              activeColor: sliderColor,
              onChanged: (p) {
                setState(() {
                  _value = p;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
