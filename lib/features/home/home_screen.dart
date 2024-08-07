import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_flutter/features/home/fab_add_task.dart';
import 'package:todo_app_flutter/features/tasks_module/list_tasks/presentation/tasks_bloc/tasks_bloc.dart';
import 'package:todo_app_flutter/features/home/tasks_list_view.dart';
import 'package:todo_app_flutter/service_locator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TasksBloc>(
      create: (_) => TasksBloc(
        fetchTasks: serviceLocator(),
        tasksStreamState: serviceLocator(),
      )..add(FetchTasksEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Lista de tareas'),
        ),
        body: _body(),
        floatingActionButton: const FabAddTask(),
      ),
    );
  }

  Widget _body() {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        if (state is FetchedTasks) {
          return TasksListView(tasks: state.tasks);
        }
        if (state is FailRecoverTasksState) {
          return const Center(
            child: Text('ocurrio un error al obtener las tareas'),
          );
        }
        return const Center(
          child: Text('Cargando...'),
        );
      },
    );
  }
}
