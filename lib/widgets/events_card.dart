import 'package:flutter/material.dart';

class EventsCard extends StatelessWidget {
  final Widget child;
  final Image image;
  final String? title;
  final String? subtitle;

  const EventsCard({
    super.key,
    required this.child,
    required this.image,
    this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 1,
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: double.infinity,
            height: 160,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image(
                  image: image.image,
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
                        Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(0.7),
                        Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(0.6),
                        Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(0),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (title != null)
                        Text(
                          title!,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.background,
                              ),
                        ),
                      if (subtitle != null)
                        Text(
                          subtitle!,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.background,
                              ),
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
          child,
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
