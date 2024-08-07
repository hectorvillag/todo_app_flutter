import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:todo_app_flutter/features/tasks_module/shared/domain/task.dart';
import 'package:todo_app_flutter/features/tasks_module/list_tasks/domain/fetch_tasks.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TasksBloc({required this.fetchTasks}) : super(TasksInitialState()) {
    on<FetchTasksEvent>(_fetchTasksEvent);
  }

  final FetchTasks fetchTasks;

  _fetchTasksEvent(FetchTasksEvent event, Emitter<TasksState> emit) async {
    emit(LoadingTasksState());
    final result = await fetchTasks.call();
    result.fold(
        (left) => emit(FailRecoverTasksState()),
        (right) => emit(
              FetchedTasks(right),
            ));
  }
}
