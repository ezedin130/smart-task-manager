import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/filtered_task_provider.dart';
import '../providers/task_provider.dart';
import '../providers/filter_provider.dart';
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
    final tasks = ref.watch(taskProvider);
    final filter = ref.watch(filterProvider);

    final filteredTasks = ref.watch(filteredTasksProvider);


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.tealAccent,
        title: const Text('Tasks'),
        actions: [
          IconButton(
            icon: Icon(isCalendarView ? Icons.list : Icons.calendar_month),
            onPressed: () => setState(() => isCalendarView = !isCalendarView),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            FilterChips(),
            Expanded(
              child: isCalendarView
                  ? CalendarWidget(tasks: filteredTasks)
                  : ListView.builder(
                itemCount: filteredTasks.length,
                itemBuilder: (context, index) {
                  final task = filteredTasks[index];
                  return TaskCard(task: task);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddEditTaskPage(task: null),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
