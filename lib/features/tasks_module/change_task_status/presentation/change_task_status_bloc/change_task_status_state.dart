part of 'change_task_status_bloc.dart';

sealed class ChangeTaskStatusState extends Equatable {
  const ChangeTaskStatusState();

  @override
  List<Object> get props => [];
}

class ChangeTaskStatusInitialState  extends ChangeTaskStatusState{}

class ChangeTaskStatusSuccessState  extends ChangeTaskStatusState{
  const ChangeTaskStatusSuccessState(this.task);
  final Task task;

  @override
  List<Object> get props => [task];
}

class ChangeTaskStatusFailState  extends ChangeTaskStatusState{}