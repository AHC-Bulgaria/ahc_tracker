import 'package:ahc_tracker/models/Event.dart';
import 'package:ahc_tracker/utils/formaters.dart';
import 'package:ahc_tracker/widgets/heat_indicator.dart';
import 'package:flutter/material.dart';

class DayDetails extends StatelessWidget {
  final Event event;

  const DayDetails({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    List<Widget> header = [
      SizedBox(
        width: double.infinity,
        height: 200,
        child: Stack(
          children: [
            Image.asset(
              'assets/images/severity/severity-${event.severity.index + 1}.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomLeft,
                  colors: [
                    Theme.of(context).colorScheme.background.withOpacity(1),
                    Theme.of(context).colorScheme.background.withOpacity(0.9),
                    Theme.of(context).colorScheme.background.withOpacity(0.8),
                    Theme.of(context).colorScheme.background.withOpacity(0.2),
                    Theme.of(context).colorScheme.background.withOpacity(0),
                  ],
                ),
              ),
            ),
            SafeArea(
              child: Column(
                children: [
                  AppBar(
                      backgroundColor: Colors.transparent,
                      title: Text(
                        dateReadble.format(event.date),
                      ),
                      actions: [
                        IconButton(
                          icon: const Icon(Icons.edit_outlined),
                          onPressed: () {},
                        )
                      ]),
                ],
              ),
            ),
          ],
        ),
      ),
      Container(
        color: event.severity.color,
        height: 6,
      )
    ];

    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   title: Text(
      //     dateReadble.format(event.date),
      //   ),
      // ),
      body: Column(
        children: [
          ...header,
          ListTile(
            leading: const Icon(Icons.speed_outlined),
            title: const Text('Average'),
            subtitle: const Text('Severity'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                HeatIndicator(
                  value: event.severity.index / 4,
                ),
                const SizedBox(width: 5),
                Text(
                  '${event.severity.index + 1}/5',
                  style: const TextStyle(fontSize: 16),
                )
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.speed_outlined),
            title: const Text('Dystonia'),
            subtitle: const Text('Severity'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                HeatIndicator(
                  value: event.severity.index / 4,
                ),
                const SizedBox(width: 5),
                Text(
                  '${event.severity.index + 1}/5',
                  style: const TextStyle(fontSize: 16),
                )
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.speed_outlined),
            title: const Text('Hemiplegia'),
            subtitle: const Text('Severity'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                HeatIndicator(
                  value: event.severity.index / 4,
                ),
                const SizedBox(width: 5),
                Text(
                  '${event.severity.index + 1}/5',
                  style: const TextStyle(fontSize: 16),
                )
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.speed_outlined),
            title: const Text('Behavior'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                HeatIndicator(
                  value: event.severity.index / 4,
                ),
                const SizedBox(width: 5),
                Text(
                  '${event.severity.index + 1}/5',
                  style: const TextStyle(fontSize: 16),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
