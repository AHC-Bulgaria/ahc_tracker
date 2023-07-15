import 'package:ahc_tracker/models/event.dart';
import 'package:ahc_tracker/utils/formaters.dart';
import 'package:ahc_tracker/widgets/severity_slider.dart';
import 'package:flutter/material.dart';

class ManageEvent extends StatefulWidget {
  const ManageEvent({super.key});

  @override
  State<ManageEvent> createState() => _ManageEvent();
}

class _ManageEvent extends State<ManageEvent> {
  final double _value = 0;
  DateTime _date = DateTime.now();

  @override
  Widget build(BuildContext context) {
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
        FilledButton.icon(
          icon: const Icon(Icons.save_outlined),
          label: const Text('Save'),
          onPressed: () async {
            Event(date: _date, severity: EventSeverity.values[_value.toInt()])
                .save();
            Navigator.of(context).pop();
          },
        ),
      ],
      body: SingleChildScrollView(
        child: Container(
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
              Text(
                'Dystonia Details',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),

              TextFormField(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Number of Dystonia Events'),
              ),
              const SizedBox(height: 8),
              SeveritySlider(
                  label: 'Dystonia Avg. Severity', onChange: (p) => {print(p)}),
              // Severity
              Text(
                'Hemiplegia Details',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SeveritySlider(
                  label: 'Hemiplegia Avg. Severity',
                  onChange: (p) => {print(p)}),
              // Severity
              Text(
                'Behavioral Details',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SeveritySlider(
                  label: 'Behavior Avg. Severity', onChange: (p) => {print(p)}),
              // Severity
            ],
          ),
        ),
      ),
    );
  }
}
