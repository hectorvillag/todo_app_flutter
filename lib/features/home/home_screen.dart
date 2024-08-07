import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_flutter/features/tasks_module/add_task/presentation/add_task_view.dart';
import 'package:todo_app_flutter/features/tasks_module/list_tasks/presentation/tasks_bloc/tasks_bloc.dart';
import 'package:todo_app_flutter/features/home/tasks_list_view.dart';
import 'package:todo_app_flutter/service_locator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de tareas'),
      ),
      body: _body(),
      floatingActionButton: _addTaskButton(context),
    );
  }

  Widget _body() {
    return BlocProvider<TasksBloc>(
      create: (_) => TasksBloc(fetchTasks: serviceLocator())..add(FetchTasksEvent()),
      child: BlocBuilder<TasksBloc, TasksState>(
        builder: (context, state) {
          switch (state) {
            case FetchedTasks():
              return TasksListView(tasks: state.tasks);
            case FailRecoverTasksState():
              return const Center(
                child: Text('ocurrio un error al obtener las tareas'),
              );
            case LoadingTasksState():
            case TasksInitialState():
              return const Center(
                child: Text('Cargando...'),
              );
          }
        },
      ),
    );
  }

  Widget _addTaskButton(BuildContext context) {
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
