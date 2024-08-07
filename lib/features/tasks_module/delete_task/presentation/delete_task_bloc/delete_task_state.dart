part of 'delete_task_bloc.dart';

sealed class DeleteTaskState extends Equatable {
  const DeleteTaskState();

  @override
  List<Object> get props => [];
}

class DeleteTaskInitialState extends DeleteTaskState{}

class DeleteTaskSuccessState extends DeleteTaskState {}

class FailedToDeleteTaskState extends DeleteTaskState {}