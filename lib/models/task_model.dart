import 'package:flutter/material.dart';

enum TaskCategory { assignment, test, project, other }

class TaskModel {
  final String id;
  final String title;
  final String description;
  final DateTime deadline;
  final TaskCategory category;
  final bool isCompleted;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.deadline,
    required this.category,
    required this.isCompleted,
  });
  bool get isOverdue => !isCompleted && deadline.isBefore(DateTime.now());
}
