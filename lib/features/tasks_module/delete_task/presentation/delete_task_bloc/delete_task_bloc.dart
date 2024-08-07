import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:todo_app_flutter/features/tasks_module/delete_task/domain/delete_task.dart';
import 'package:todo_app_flutter/features/tasks_module/shared/domain/models/task.dart';
import 'package:todo_app_flutter/features/tasks_module/shared/infrastructure/tasks_stream.dart';
part 'delete_task_event.dart';
part 'delete_task_state.dart';

class DeleteTaskBloc extends Bloc<DeleteTaskEvent, DeleteTaskState> {
  DeleteTaskBloc({required this.deleteTask, required this.tasksStreamState})
      : super(DeleteTaskInitialState()) {
    on<RemoveTaskEvent>(_deleteTaskEvent);
  }

  final DeleteTask deleteTask;
  final TasksStreamState tasksStreamState;

  _deleteTaskEvent(RemoveTaskEvent event, Emitter<DeleteTaskState> emit) async {
    final result = await deleteTask(event.task);

    await result.fold(
      (left) async => emit(FailedToDeleteTaskState()),
      (_) async {
        tasksStreamState.delete(event.task);
        emit(DeleteTaskSuccessState());
      },
    );
  }
}
