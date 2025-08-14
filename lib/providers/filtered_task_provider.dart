import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task_model.dart';
import 'task_provider.dart';
import 'filter_provider.dart';

final filteredTasksProvider = Provider<List<TaskModel>>((ref) {
  final tasks = ref.watch(taskProvider);
  final filter = ref.watch(filterProvider);

  return tasks.where((task) {
    final matchesCategory = filter.category == null || task.category == filter.category;
    final matchesCompleted = !filter.showCompleted || task.isCompleted;
    final matchesOverdue = !filter.showOverdue || task.isOverdue;
    return matchesCategory && matchesCompleted && matchesOverdue;
  }).toList();
});
