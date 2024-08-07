import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:todo_app_flutter/features/tasks_module/shared/domain/task.dart';
import 'package:todo_app_flutter/features/tasks_module/list_tasks/domain/fetch_tasks.dart';
import 'package:todo_app_flutter/features/tasks_module/shared/infrastructure/tasks_stream.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TasksBloc({required this.fetchTasks, required this.tasksStreamState})
      : super(TasksInitialState()) {
    on<FetchTasksEvent>(_fetchTasksEvent);
  }

  final FetchTasks fetchTasks;
  final TasksStreamState tasksStreamState;

  _fetchTasksEvent(FetchTasksEvent event, Emitter<TasksState> emit) async {
    emit(LoadingTasksState());

    final result = await fetchTasks();

    await result.fold((left) async => emit(FailRecoverTasksState()),
        (tasks) async {
      tasksStreamState.replaceAll(tasks);
      await emit.forEach(
        tasksStreamState.streamEntities,
        onData: (tasks) {
          return FetchedTasks(tasks);
        },
        onError: (error, stackTrace) {
          return FailRecoverTasksState();
        },
      );
    });
  }
}
