import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_providers.dart';
import 'add_edit_task_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final tasks = _searchQuery.isEmpty
        ? taskProvider.tasks
        : taskProvider.searchTasks(_searchQuery);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo Task Manager'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => taskProvider.refreshTasks(),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search tasks...',
                fillColor: Colors.white,
                filled: true,
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
        ),
      ),
      body: tasks.isEmpty
          ? const Center(child: Text("No Data Found"))
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (_, index) {
                final task = tasks[index];
                return ListTile(
                  leading: Checkbox(
                    value: task.isCompleted,
                    onChanged: (_) {
                      taskProvider.toggleComplete(task.id);
                      if (taskProvider.tasks
                          .firstWhere((t) => t.id == task.id)
                          .isCompleted) {
                        Future.delayed(const Duration(milliseconds: 300), () {
                          taskProvider.deleteTask(task.id);
                        });
                      }
                    },
                  ),
                  title: Text(
                    task.title,
                    style: TextStyle(
                      decoration:
                          task.isCompleted ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  subtitle: Text(task.description),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => taskProvider.deleteTask(task.id),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AddEditTaskScreen(task: task),
                      ),
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddEditTaskScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
