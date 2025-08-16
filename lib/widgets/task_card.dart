import 'package:flutter/material.dart';
import '../models/task_model.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task;
  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
        color: task.isOverdue ? Colors.red[50] : Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
      child: ListTile(
        leading: Icon(
          task.isCompleted ? Icons.check_circle : Icons.circle_outlined,
          color: task.isCompleted ? Colors.green : Colors.grey,
        ),
        title: Text(
          task.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            decoration: task.isCompleted
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        subtitle: Text(
          task.description,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Text(
          "${task.deadline.day}/${task.deadline.month}",
          style: TextStyle(
            color: task.isOverdue ? Colors.red : Colors.black54,
          ),
        ),
      ),
    );
  }
}
