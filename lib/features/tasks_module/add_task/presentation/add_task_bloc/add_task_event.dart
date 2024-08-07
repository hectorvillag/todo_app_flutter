part of 'add_task_bloc.dart';

sealed class AddTaskEvent extends Equatable {
  const AddTaskEvent();

  @override
  List<Object> get props => [];
}


class CreateTaskEvent extends AddTaskEvent{
  const CreateTaskEvent(this.task);
  
  final Task task;
}