import 'package:flutter/material.dart';

class HeatIndicator extends StatelessWidget {
  const HeatIndicator({super.key, required this.value, this.size = 100});

  final double value;
  final int size;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: size + 24,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                transform: Matrix4.translationValues(value * size, 0, 0),
                child: const Icon(
                  Icons.arrow_drop_down,
                  size: 24,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: size.toDouble(),
          child: Container(
            height: 4,
            transform: Matrix4.translationValues(0.0, -4, 0.0),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.topRight,
                colors: [
                  Colors.green,
                  Colors.lime,
                  Colors.yellow,
                  Colors.orange,
                  Colors.red
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
