import 'package:flutter/material.dart';
import 'package:todo_app_flutter/features/tasks_module/di_tasks.dart';
import 'package:todo_app_flutter/todo_app.dart';

void main() {
  setupTasksDI();
  runApp(const TodoApp());
}


