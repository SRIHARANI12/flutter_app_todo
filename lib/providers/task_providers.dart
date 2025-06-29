import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/task.dart';

class TaskProvider with ChangeNotifier {
  final List<Task> _tasks = [];

  List<Task> get tasks => [..._tasks];

  void addTask(String title, String description) {
    final task = Task(
      id: const Uuid().v4(),
      title: title,
      description: description,
    );
    _tasks.add(task);
    notifyListeners();
  }

  void updateTask(String id, String newTitle, String newDescription) {
    final index = _tasks.indexWhere((task) => task.id == id);
    if (index != -1) {
      _tasks[index].title = newTitle;
      _tasks[index].description = newDescription;
      notifyListeners();
    }
  }

  void toggleComplete(String id) {
    final task = _tasks.firstWhere((task) => task.id == id);
    task.isCompleted = !task.isCompleted;
    notifyListeners();
  }

  void deleteTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
    notifyListeners();
  }

  List<Task> searchTasks(String query) {
    return _tasks
        .where((task) =>
            task.title.toLowerCase().contains(query.toLowerCase()) ||
            task.description.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  void refreshTasks() {
    notifyListeners();
  }
}
