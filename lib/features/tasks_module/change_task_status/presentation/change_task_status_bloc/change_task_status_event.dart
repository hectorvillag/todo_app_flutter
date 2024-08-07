part of 'change_task_status_bloc.dart';

sealed class ChangeTaskStatusEvent extends Equatable {
  const ChangeTaskStatusEvent();

  @override
  List<Object> get props => [];
}

class RequestChangeTaskStatusEvent extends  ChangeTaskStatusEvent{
  const RequestChangeTaskStatusEvent(this.task,this.isDone);
  
  final Task task;
  final bool isDone;

  @override
  List<Object> get props => [task,isDone];
}