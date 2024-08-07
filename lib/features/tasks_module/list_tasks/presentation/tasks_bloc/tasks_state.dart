part of 'tasks_bloc.dart';

sealed class TasksState extends Equatable {
  const TasksState();

  @override
  List<Object> get props => [];
}

class TasksInitialState extends TasksState {}

class LoadingTasksState extends TasksState {}

class FetchedTasks extends TasksState {
  const FetchedTasks(this.tasks);

  final List<Task> tasks;
}

class FailRecoverTasksState extends TasksState {}
