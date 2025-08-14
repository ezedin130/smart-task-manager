import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task_model.dart';
import '../providers/filter_provider.dart';

class FilterChips extends ConsumerWidget {
  const FilterChips({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(filterProvider);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(8),
      child: Wrap(
        spacing: 8,
        children: [
          // Category chips
          ChoiceChip(
            label: const Text('Assignment'),
            selected: filter.category == TaskCategory.assignment,
            onSelected: (_) => ref.read(filterProvider.notifier)
                .setCategory(filter.category == TaskCategory.assignment ? null : TaskCategory.assignment),
          ),
          ChoiceChip(
            label: const Text('Test'),
            selected: filter.category == TaskCategory.test,
            onSelected: (_) => ref.read(filterProvider.notifier)
                .setCategory(filter.category == TaskCategory.test ? null : TaskCategory.test),
          ),
          ChoiceChip(
            label: const Text('Project'),
            selected: filter.category == TaskCategory.project,
            onSelected: (_) => ref.read(filterProvider.notifier)
                .setCategory(filter.category == TaskCategory.project ? null : TaskCategory.project),
          ),
          ChoiceChip(
            label: const Text('Other'),
            selected: filter.category == TaskCategory.other,
            onSelected: (_) => ref.read(filterProvider.notifier)
                .setCategory(filter.category == TaskCategory.other ? null : TaskCategory.other),
          ),
          // Completed / Overdue
          FilterChip(
            label: const Text('Completed'),
            selected: filter.showCompleted,
            onSelected: (_) => ref.read(filterProvider.notifier).toggleCompleted(),
          ),
          FilterChip(
            label: const Text('Overdue'),
            selected: filter.showOverdue,
            onSelected: (_) => ref.read(filterProvider.notifier).toggleOverdue(),
          ),
        ],
      ),
    );
  }
}
