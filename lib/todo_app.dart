import 'package:flutter/material.dart';
import 'package:todo_app_flutter/features/home/home_screen.dart';
import 'package:todo_app_flutter/shared/task_app_colors.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Todo App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: TaskAppColors.colorSchemeSeed),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}