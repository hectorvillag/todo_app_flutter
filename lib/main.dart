import 'package:flutter/material.dart';
import 'package:todo_app_flutter/features/logger/logger_di.dart';
import 'package:todo_app_flutter/features/tasks_module/tasks_di.dart';
import 'package:todo_app_flutter/todo_app.dart';

void main() {
  setupLoggerDI();
  setupTasksDI();
  
  runApp(const TodoApp());
}


