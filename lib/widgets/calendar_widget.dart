import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../models/task_model.dart';

class CalendarWidget extends StatelessWidget {
  final List<TaskModel> tasks;
  const CalendarWidget({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2100, 12, 31),
      focusedDay: DateTime.now(),
      calendarBuilders: CalendarBuilders(
        markerBuilder: (context, day, events) {
          final dayTasks = tasks.where((t) => isSameDay(t.deadline, day));
          if (dayTasks.isNotEmpty) {
            return Positioned(
              bottom: 1,
              child: Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
              ),
            );
          }
          return null;
        },
      ),
    );
  }
}
