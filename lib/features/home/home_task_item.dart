import 'package:flutter/material.dart';
import 'package:todo_app_flutter/features/tasks_module/domain/task.dart';
import 'package:todo_app_flutter/shared/colors.dart';

class HomeTaskItem extends StatelessWidget {
  const HomeTaskItem(this.task, {super.key});

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 6.0, bottom: 6.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: const [
          BoxShadow(
            color: TaskAppColors.shadow,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        children: [
          Radio(
              value: task.isDone,
              groupValue: !task.isDone,
              onChanged: (value) {}),
          Column(
            children: [Text(task.title), Text(task.description)],
          )
        ],
      ),
    );
  }
}
