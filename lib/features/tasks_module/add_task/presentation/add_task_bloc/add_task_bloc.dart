import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:todo_app_flutter/features/tasks_module/shared/domain/task.dart';
import 'package:todo_app_flutter/features/tasks_module/add_task/domain/add_task.dart';
import 'package:todo_app_flutter/features/tasks_module/shared/infrastructure/tasks_stream.dart';
part 'add_task_event.dart';
part 'add_task_state.dart';

class AddTaskBloc extends Bloc<AddTaskEvent, AddTaskState> {
  AddTaskBloc({required this.addTask,required this.tasksStreamState})
      : super(AddTaskInitialState()) {
    on<CreateTaskEvent>(_addTaskEvent);
  }

  final AddTask addTask;
  final TasksStreamState tasksStreamState;

  _addTaskEvent(CreateTaskEvent event, Emitter<AddTaskState> emit) async {
    emit(SavingTaskState());
    final result = await addTask(event.task);
    
    await result.fold((left)async  => emit(FailedToAddTaskState()), (task)async  {
      tasksStreamState.add(task);
      emit(AddTaskSuccessState());
    });
  }
}
