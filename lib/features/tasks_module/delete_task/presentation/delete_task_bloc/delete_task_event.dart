part of 'delete_task_bloc.dart';

sealed class DeleteTaskEvent extends Equatable {
  const DeleteTaskEvent();

  @override
  List<Object> get props => [];
}


class RemoveTaskEvent extends DeleteTaskEvent{
  const RemoveTaskEvent(this.task);
  
  final Task task;
}