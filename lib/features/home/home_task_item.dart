import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_flutter/features/tasks_module/change_task_status/change_task_status_bloc/change_task_status_bloc.dart';
import 'package:todo_app_flutter/features/tasks_module/shared/domain/task.dart';
import 'package:todo_app_flutter/service_locator.dart';
import 'package:todo_app_flutter/shared/colors.dart';

class HomeTaskItem extends StatefulWidget {
  const HomeTaskItem(
      {super.key, required this.task, required this.onUpdateTask});

  final Task task;
  final Function(BuildContext) onUpdateTask;

  @override
  State<HomeTaskItem> createState() => _HomeTaskItemState();
}

class _HomeTaskItemState extends State<HomeTaskItem> {
  late Task task;
  @override
  void initState() {
    super.initState();
    task = widget.task;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChangeTaskStatusBloc>(
      create: (context) {
        return ChangeTaskStatusBloc(
            changeTaskStatus: serviceLocator(),
            tasksStreamState: serviceLocator());
      },
      child: BlocConsumer<ChangeTaskStatusBloc, ChangeTaskStatusState>(
        listener: (context, state) {
          if(state is ChangeTaskStatusSuccessState){
            setState(() {
              task = state.task;
            });
          }
        },
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
