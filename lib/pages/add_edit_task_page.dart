import 'package:flutter/material.dart';
import '../models/task_model.dart';

class AddEditTaskPage extends StatefulWidget {
  final TaskModel? task;
  const AddEditTaskPage({super.key, this.task});

  @override
  State<AddEditTaskPage> createState() => _AddEditTaskPageState();
}

class _AddEditTaskPageState extends State<AddEditTaskPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController titleController;
  late TextEditingController descController;
  DateTime? selectedDate;
  TaskCategory? selectedCategory;
  bool isCompleted = false;

  @override
  void initState() {
    super.initState();
    titleController =
        TextEditingController(text: widget.task?.title ?? '');
    descController =
        TextEditingController(text: widget.task?.description ?? '');
    selectedDate = widget.task?.deadline ?? DateTime.now();
    selectedCategory = widget.task?.category ?? TaskCategory.assignment;
    isCompleted = widget.task?.isCompleted ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.task == null ? 'Add Task' : 'Edit Task')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextFormField(
                controller: descController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              ListTile(
                title: Text('Deadline: ${selectedDate?.toLocal().toString().split(' ')[0]}'),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: selectedDate ?? DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) setState(() => selectedDate = picked);
                },
              ),
              DropdownButton<TaskCategory>(
                value: selectedCategory,
                items: TaskCategory.values.map((e) {
                  return DropdownMenuItem(
                    value: e,
                    child: Text(e.name.toUpperCase()),
                  );
                }).toList(),
                onChanged: (val) => setState(() => selectedCategory = val),
              ),
              SwitchListTile(
                title: const Text('Completed'),
                value: isCompleted,
                onChanged: (val) => setState(() => isCompleted = val),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final newTask = TaskModel(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    title: titleController.text,
                    description: descController.text,
                    deadline: selectedDate!,
                    category: selectedCategory!,
                    isCompleted: false,
                  );

                  Navigator.pop(context, newTask);
                },
                child: const Text("Save Task"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
