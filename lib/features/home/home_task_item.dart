import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_flutter/features/tasks_module/change_task_status/change_task_status_bloc/change_task_status_bloc.dart';
import 'package:todo_app_flutter/features/tasks_module/shared/domain/models/task.dart';
import 'package:todo_app_flutter/service_locator.dart';
import 'package:todo_app_flutter/shared/colors.dart';

class HomeTaskItem extends StatelessWidget {
  const HomeTaskItem({super.key, required this.task});

  final Task task;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChangeTaskStatusBloc>(
      create: (context) {
        return ChangeTaskStatusBloc(
            changeTaskStatus: serviceLocator(),
            tasksStreamState: serviceLocator());
      },
      child: BlocBuilder<ChangeTaskStatusBloc, ChangeTaskStatusState>(
        builder: (context, state) {
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
                Checkbox(
                    value: task.isDone,
                    onChanged: (value) {
                      BlocProvider.of<ChangeTaskStatusBloc>(context).add(
                          RequestChangeTaskStatusEvent(task, !task.isDone));
                    }),
                Column(
                  children: [Text(task.title), Text(task.description)],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
