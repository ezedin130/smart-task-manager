import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task_model.dart';

// Initial mock tasks
final List<TaskModel> initialTasks = [
  TaskModel(
      id: '1',
      title: 'Math Assignment',
      description: 'Chapter 5 problems',
      deadline: DateTime.now().add(const Duration(days: 1)),
      category: TaskCategory.assignment,
      isCompleted: false),
  TaskModel(
      id: '2',
      title: 'Science Test',
      description: 'Physics chapter 2',
      deadline: DateTime.now().subtract(const Duration(days: 1)),
      category: TaskCategory.test,
      isCompleted: false),
  TaskModel(
      id: '3',
      title: 'Project Submission',
      description: 'History presentation',
      deadline: DateTime.now().add(const Duration(days: 3)),
      category: TaskCategory.project,
      isCompleted: true),
];

class TaskNotifier extends StateNotifier<List<TaskModel>> {
  TaskNotifier() : super(initialTasks);

  void addTask(TaskModel task) {
    state = [...state, task];
  }

  void updateTask(TaskModel updatedTask) {
    state = [
      for (final task in state)
        if (task.id == updatedTask.id) updatedTask else task
    ];
  }

  void deleteTask(String id) {
    state = state.where((task) => task.id != id).toList();
  }

  void toggleComplete(String id) {
    state = [
      for (final task in state)
        if (task.id == id)
          TaskModel(
            id: task.id,
            title: task.title,
            description: task.description,
            deadline: task.deadline,
            category: task.category,
            isCompleted: !task.isCompleted,
          )
        else
          task
    ];
  }
}

final taskProvider =
StateNotifierProvider<TaskNotifier, List<TaskModel>>((ref) => TaskNotifier());
