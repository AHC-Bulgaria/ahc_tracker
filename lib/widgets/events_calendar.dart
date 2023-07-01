import 'package:ahc_tracker/models/event.dart';
import 'package:ahc_tracker/screens/day_details.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

final kToday = DateTime.now();
final kFirstDay = DateTime(1900);

List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

class EventsCalendar extends StatefulWidget {
  const EventsCalendar({super.key});

  @override
  State<EventsCalendar> createState() => _EventsCalendar();
}

class _EventsCalendar extends State<EventsCalendar> {
  DateTime _focusedDay = kToday;
  DateTime? _selectedDay;
  // DateTime? _rangeStart;
  // DateTime? _rangeEnd;
  Map<DateTime, Event?> _rangeEvents = {};

  @override
  initState() {
    _getRangeEvents();
    super.initState();
  }

  List<Event> _getEventsForDay(DateTime day) {
    return _rangeEvents[day] != null ? [_rangeEvents[day]!] : [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) async {
    if (!isSameDay(_selectedDay, selectedDay)) {
      if (_rangeEvents[selectedDay] != null) {
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => DayDetails(
              event: _rangeEvents[selectedDay]!,
            ),
          ),
        );
      }
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        // _rangeStart = null;
        // _rangeEnd = null;
      });
    }
  }

  Future<void> _getRangeEvents() async {
    final refDay = _focusedDay;

    final DateTime start = refDay.subtract(Duration(days: refDay.day - 1));
    final DateTime end = DateTime(refDay.year, refDay.month + 1)
        .subtract(const Duration(days: 1));

    final rangeEvents = await Event.fromDateRange(start, end);
    setState(() {
      _rangeEvents = rangeEvents;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar<Event>(
      // locale: Localizations.localeOf(context).languageCode,
      firstDay: kFirstDay,
      lastDay: kToday,
      focusedDay: _focusedDay,
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      // rangeStartDay: _rangeStart,
      // rangeEndDay: _rangeEnd,
      calendarFormat: CalendarFormat.month,
      rangeSelectionMode: RangeSelectionMode.disabled,
      eventLoader: _getEventsForDay,
      startingDayOfWeek: StartingDayOfWeek.monday,
      availableCalendarFormats: const {
        CalendarFormat.month: 'Month',
      },
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
          shape: BoxShape.circle,
        ),
        selectedTextStyle:
            TextStyle(color: Theme.of(context).textTheme.headlineLarge!.color),
        selectedDecoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
          shape: BoxShape.circle,
        ),
        outsideDaysVisible: false,
        markersAlignment: Alignment.bottomRight,
      ),
      calendarBuilders: CalendarBuilders(
        markerBuilder: (context, day, events) => events.isNotEmpty
            ? Card(
                elevation: 1,
                child: Container(
                  width: 16,
                  height: 16,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: events[0].severity.color.withOpacity(0.7),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Text(
                    '',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondary,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
            : null,
      ),
      onDaySelected: _onDaySelected,
      onPageChanged: (focusedDay) {
        setState(() {
          _focusedDay = focusedDay;
          _getRangeEvents();
        });
      },
    );
  }
}
