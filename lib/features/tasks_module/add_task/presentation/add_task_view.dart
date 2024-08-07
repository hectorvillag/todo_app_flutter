import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_flutter/features/tasks_module/add_task/presentation/add_task_form.dart';
import 'package:todo_app_flutter/features/tasks_module/add_task/presentation/add_task_bloc/add_task_bloc.dart';
import 'package:todo_app_flutter/service_locator.dart';

class AddTaskView extends StatefulWidget {
  const AddTaskView({super.key});

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddTaskBloc>(
      create: (_) => AddTaskBloc(
        addTask: serviceLocator(),
        tasksStreamState: serviceLocator(),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Agregar tarea'),
        ),
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: AddTaskForm(),
          ),
        ),
      ),
    );
  }
}
