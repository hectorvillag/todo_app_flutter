import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:todo_app_flutter/features/tasks_module/change_task_status/change_task_status.dart';
import 'package:todo_app_flutter/features/tasks_module/shared/domain/task.dart';
import 'package:todo_app_flutter/features/tasks_module/shared/infrastructure/tasks_stream.dart';
part 'change_task_status_event.dart';
part 'change_task_status_state.dart';

class ChangeTaskStatusBloc extends Bloc<ChangeTaskStatusEvent, ChangeTaskStatusState> {
  ChangeTaskStatusBloc({required this.changeTaskStatus,required this.tasksStreamState,})
      : super(ChangeTaskStatusInitialState()) {
    on<RequestChangeTaskStatusEvent>(_requestChangeTaskStatusEvent);
  }

  final ChangeTaskStatus changeTaskStatus;
  final TasksStreamState tasksStreamState;

  _requestChangeTaskStatusEvent(RequestChangeTaskStatusEvent event, Emitter<ChangeTaskStatusState> emit) async {
    final result = await changeTaskStatus(event.task,event.isDone);

    result.fold((left) => emit(ChangeTaskStatusFailState()), (task) {
      tasksStreamState.update(task);
      emit(ChangeTaskStatusSuccessState(task)); 
    });
  }
}
