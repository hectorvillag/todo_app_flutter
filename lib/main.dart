import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app_flutter/features/logger/logger_di.dart';
import 'package:todo_app_flutter/features/tasks_module/shared/infrastructure/task_dto.dart';
import 'package:todo_app_flutter/features/tasks_module/tasks_di.dart';
import 'package:todo_app_flutter/todo_app.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();

  setupLoggerDI();
  setupTasksDI();

  await Hive.initFlutter();
  Hive.registerAdapter(TaskDTOAdapter());
  
  runApp(const TodoApp());
}


