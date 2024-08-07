import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_flutter/features/tasks_module/add_task/presentation/add_task_view.dart';

class FabAddTask extends StatelessWidget{
  const FabAddTask({super.key});

  @override
  Widget build(BuildContext context) {
   return OpenContainer(
      transitionType: ContainerTransitionType.fade,
      openBuilder: (BuildContext context, VoidCallback _) {
        return const AddTaskView();
      },
      closedElevation: 6.0,
      closedShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(48.0 / 2),
        ),
      ),
      closedColor: Theme.of(context).colorScheme.secondary,
      closedBuilder: (BuildContext context, VoidCallback openContainer) {
        return SizedBox(
          height: 48.0,
          width: 48.0,
          child: Center(
            child: Icon(
              Icons.add,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
        );
      },
    );
  }
  
}