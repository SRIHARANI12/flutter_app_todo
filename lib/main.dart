import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/task_providers.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TaskProvider(),
      child: MaterialApp(
        title: 'Todo Task Manager',
        debugShowCheckedModeBanner: false, // 👈 This hides the debug banner
        theme: ThemeData(primarySwatch: Colors.teal),
        home: const HomeScreen(),
      ),
    );
  }
}
