import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task_model.dart';

class FilterState {
  final TaskCategory? category;
  final bool showCompleted;
  final bool showOverdue;

  FilterState({
    this.category,
    this.showCompleted = false,
    this.showOverdue = false,
  });

  FilterState copyWith({
    TaskCategory? category,
    bool? showCompleted,
    bool? showOverdue,
  }) {
    return FilterState(
      category: category ?? this.category,
      showCompleted: showCompleted ?? this.showCompleted,
      showOverdue: showOverdue ?? this.showOverdue,
    );
  }
}

class FilterNotifier extends StateNotifier<FilterState> {
  FilterNotifier() : super(FilterState());

  void setCategory(TaskCategory? category) {
    state = state.copyWith(category: category);
  }

  void toggleCompleted() {
    state = state.copyWith(showCompleted: !state.showCompleted);
  }

  void toggleOverdue() {
    state = state.copyWith(showOverdue: !state.showOverdue);
  }
}

final filterProvider =
StateNotifierProvider<FilterNotifier, FilterState>((ref) => FilterNotifier());
