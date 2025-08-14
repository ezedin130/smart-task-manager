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
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Row(
        children: [
          ChoiceChip(
            label: const Text('All'),
            selected:
                filter.category == null &&
                !filter.showCompleted &&
                !filter.showOverdue,
            onSelected: (_) {
              ref.read(filterProvider.notifier).resetAll();
            },
          ),
          const SizedBox(width: 8),

          ChoiceChip(
            label: const Text('Assignment'),
            selected: filter.category == TaskCategory.assignment,
            onSelected: (_) {
              ref
                  .read(filterProvider.notifier)
                  .setCategory(
                    filter.category == TaskCategory.assignment
                        ? null
                        : TaskCategory.assignment,
                  );
            },
          ),
          const SizedBox(width: 8),

          ChoiceChip(
            label: const Text('Other'),
            selected: filter.category == TaskCategory.other,
            onSelected: (_) {
              ref
                  .read(filterProvider.notifier)
                  .setCategory(
                filter.category == TaskCategory.other
                    ? null
                    : TaskCategory.other,
              );
            },
          ),
          const SizedBox(width: 8),

          ChoiceChip(
            label: const Text('Test'),
            selected: filter.category == TaskCategory.test,
            onSelected: (_) {
              ref
                  .read(filterProvider.notifier)
                  .setCategory(
                    filter.category == TaskCategory.test
                        ? null
                        : TaskCategory.test,
                  );
            },
          ),
          const SizedBox(width: 8),

          ChoiceChip(
            label: const Text('Project'),
            selected: filter.category == TaskCategory.project,
            onSelected: (_) {
              ref
                  .read(filterProvider.notifier)
                  .setCategory(
                    filter.category == TaskCategory.project
                        ? null
                        : TaskCategory.project,
                  );
            },
          ),
          const SizedBox(width: 8),

          ChoiceChip(
            label: const Text('Completed'),
            selected: filter.showCompleted,
            onSelected: (_) {
              ref
                  .read(filterProvider.notifier)
                  .setShowCompleted(!filter.showCompleted);
            },
          ),
          const SizedBox(width: 8),

          ChoiceChip(
            label: const Text('Overdue'),
            selected: filter.showOverdue,
            onSelected: (_) {
              ref
                  .read(filterProvider.notifier)
                  .setShowOverdue(!filter.showOverdue);
            },
          ),
        ],
      ),
    );
  }
}
