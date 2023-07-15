import 'package:ahc_tracker/models/event.dart';
import 'package:flutter/material.dart';

class SeveritySlider extends StatefulWidget {
  SeveritySlider(
      {super.key, required this.label, required this.onChange, this.value = 0});

  final String label;
  final void Function(double p) onChange;
  double value;

  @override
  State<SeveritySlider> createState() => _SeveritySlider();
}

class _SeveritySlider extends State<SeveritySlider> {
  @override
  Widget build(BuildContext context) {
    Color sliderColor = EventSeverity.values[widget.value.toInt()].color;

    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      const SizedBox(height: 4),
      Text(
        widget.label,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      const SizedBox(height: 4),
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
        value: widget.value,
        min: 0,
        max: 4,
        activeColor: sliderColor,
        onChanged: (p) {
          setState(() {
            widget.value = p;
            widget.onChange(p);
          });
        },
      )
    ]);
  }
}
