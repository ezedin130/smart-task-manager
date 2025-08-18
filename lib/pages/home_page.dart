import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/filtered_task_provider.dart';
import '../providers/task_provider.dart';
import '../widgets/task_card.dart';
import '../widgets/filter_chips.dart';
import '../widgets/calendar_widget.dart';
import 'add_edit_task_page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  bool isCalendarView = false;

  @override
  Widget build(BuildContext context) {
    var filteredTasks = ref.watch(filteredTasksProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tasks',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.tealAccent,
        elevation: 0,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(isCalendarView ? Icons.list : Icons.calendar_month),
            color: Colors.black87,
            onPressed: () => setState(() => isCalendarView = !isCalendarView),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: FilterChips()
              ),
            ),
            Expanded(
              child: isCalendarView
                  ? Column(
                children: [
                  SizedBox(
                    height: 100,
                    child: DaySelector(
                      tasks: filteredTasks,
                      onDaySelected: (selectedDay) {
                        setState(() {
                          filteredTasks = ref.watch(taskProvider)
                              .where((t) =>
                          t.deadline.year == selectedDay.year &&
                              t.deadline.month == selectedDay.month &&
                              t.deadline.day == selectedDay.day)
                              .toList();
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredTasks.length,
                      itemBuilder: (context, index) {
                        final task = filteredTasks[index];
                        return TaskCard(task: task);
                      },
                    ),
                  ),
                ],
              )
                  : ListView.builder(
                itemCount: filteredTasks.length,
                itemBuilder: (context, index) {
                  final task = filteredTasks[index];
                  return TaskCard(task: task);
                },
              ),
            )

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newTask = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddEditTaskPage(task: null),
            ),
          );

          if (newTask != null) {
            ref.read(taskProvider.notifier).addTask(newTask);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
