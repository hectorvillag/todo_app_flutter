import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_flutter/features/tasks_module/change_task_status/presentation/change_task_status_bloc/change_task_status_bloc.dart';
import 'package:todo_app_flutter/features/tasks_module/delete_task/presentation/delete_task_bloc/delete_task_bloc.dart';
import 'package:todo_app_flutter/features/tasks_module/shared/domain/models/task.dart';
import 'package:todo_app_flutter/service_locator.dart';
import 'package:todo_app_flutter/shared/task_app_colors.dart';

class HomeTaskItem extends StatelessWidget {
  const HomeTaskItem({super.key, required this.task});

  final Task task;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ChangeTaskStatusBloc>(
          create: (context) {
            return ChangeTaskStatusBloc(
                changeTaskStatus: serviceLocator(),
                tasksStreamState: serviceLocator());
          },
        ),
        BlocProvider<DeleteTaskBloc>(
          create: (context) {
            return DeleteTaskBloc(
                deleteTask: serviceLocator(),
                tasksStreamState: serviceLocator());
          },
        )
      ],
      child: BlocBuilder<ChangeTaskStatusBloc, ChangeTaskStatusState>(
        builder: (context, state) {
          return Container(
            margin: const EdgeInsets.only(top: 6.0, bottom: 6.0),
            decoration: BoxDecoration(
              color: TaskAppColors.taskBackground,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: const [
                BoxShadow(
                  color: TaskAppColors.shadow,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Checkbox(
                    value: task.isDone,
                    onChanged: (value) {
                      BlocProvider.of<ChangeTaskStatusBloc>(context).add(
                          RequestChangeTaskStatusEvent(task, !task.isDone));
                    }),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        task.description,
                        style: Theme.of(context).textTheme.bodySmall,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: IconButton(
                      onPressed: () async {
                        final result = await showDialog<bool>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                  title: const Text("Eliminar"),
                                  content:
                                      const Text("¿Deseas eliminar la tarea?"),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text("Si"),
                                      onPressed: () {
                                        Navigator.of(context).pop(true);
                                      },
                                    ),
                                    TextButton(
                                      child: const Text("No"),
                                      onPressed: () {
                                        Navigator.of(context).pop(false);
                                      },
                                    ),
                                  ],
                                ));
                        if ((result ?? false) && context.mounted) {
                          BlocProvider.of<DeleteTaskBloc>(context)
                              .add(RemoveTaskEvent(task));
                        }
                      },
                      icon: const Icon(Icons.delete)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
