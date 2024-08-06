import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_flutter/features/tasks_module/presentation/tasks_bloc/tasks_bloc.dart';
import 'package:todo_app_flutter/features/home/tasks_list_view.dart';

import '../tasks_module/di_tasks.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de tareas'),
      ),
      body: _body(),
      //floatingActionButton: _addTaskButton(context),
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

  
}
