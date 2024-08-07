import 'package:flutter/material.dart';
import 'package:todo_app_flutter/features/home/home_task_item.dart';
import 'package:todo_app_flutter/features/tasks_module/shared/domain/task.dart';

class TasksListView extends StatelessWidget {
  const TasksListView({
    super.key,
    required this.tasks,
  });

  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: ListView(
          children: [...tasks.map((task) => HomeTaskItem(task))],
        ));
  }
}
