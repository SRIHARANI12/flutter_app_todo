import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/task_providers.dart';

class AddEditTaskScreen extends StatefulWidget {
  final Task? task;
  const AddEditTaskScreen({super.key, this.task});

  @override
  State<AddEditTaskScreen> createState() => _AddEditTaskScreenState();
}

class _AddEditTaskScreenState extends State<AddEditTaskScreen> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  @override
  void initState() {
    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _descController.text = widget.task!.description;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.task != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Task' : 'Add Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _descController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final title = _titleController.text.trim();
                final desc = _descController.text.trim();

                if (title.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Title cannot be empty')),
                  );
                  return;
                }

                final provider =
                    Provider.of<TaskProvider>(context, listen: false);

                if (isEdit) {
                  provider.updateTask(widget.task!.id, title, desc);
                } else {
                  provider.addTask(title, desc);
                }

                Navigator.pop(context);
              },
              child: Text(isEdit ? 'Update' : 'Add'),
            ),
          ],
        ),
      ),
    );
  }
}
