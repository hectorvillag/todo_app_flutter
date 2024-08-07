part of 'add_task_bloc.dart';

sealed class AddTaskState extends Equatable {
  const AddTaskState();

  @override
  List<Object> get props => [];
}

class AddTaskInitialState extends AddTaskState{}

class SavingTaskState extends AddTaskState{}

class AddTaskSuccessState extends AddTaskState {}

class FailedToAddTaskState extends AddTaskState {}