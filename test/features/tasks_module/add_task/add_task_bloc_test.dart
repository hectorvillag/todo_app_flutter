import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_app_flutter/features/tasks_module/add_task/domain/add_task.dart';
import 'package:todo_app_flutter/features/tasks_module/add_task/domain/error_adding_task.dart';
import 'package:todo_app_flutter/features/tasks_module/add_task/presentation/add_task_bloc/add_task_bloc.dart';
import 'package:todo_app_flutter/features/tasks_module/shared/domain/models/task.dart';
import 'package:todo_app_flutter/features/tasks_module/shared/domain/models/task_builder.dart';
import 'package:todo_app_flutter/features/tasks_module/shared/infrastructure/tasks_stream.dart';

class MockAddTask extends Mock implements AddTask {}
class MockTasksStreamState extends Mock implements TasksStreamState{}

main() {
  group('AddTaskBloc', () {
    late AddTask addTask;
    late Task task;
    late TasksStreamState tasksStreamState;
    
    Task createDummyTask() {
      TaskBuilder taskBuilder = TaskBuilder();
      taskBuilder.withId(1);
      taskBuilder.withTitle('title');
      taskBuilder.withDescription('description');
      return taskBuilder.build();
    }

    setUp(() {
      addTask = MockAddTask();
      task = createDummyTask();
      tasksStreamState = MockTasksStreamState();
    });

    blocTest(
      'emits AddTaskSuccessState when CreateTaskEvent is added',
      build: () {
        when(() => addTask.call(task))
            .thenAnswer((_) async => dartz.Right(task));
        when(() => tasksStreamState.add(task)).thenReturn((){});
        return AddTaskBloc(addTask: addTask,tasksStreamState: tasksStreamState);
      },
      act: (bloc) => bloc.add(CreateTaskEvent(task)),
      expect: () => [SavingTaskState(),AddTaskSuccessState()],
      verify: (bloc) => {verify(() => addTask.call(task)).called(1)},
    );

    blocTest(
      'emits FailedToAddTaskState when CreateTaskEvent is added',
      build: () {
        when(() => addTask.call(task))
            .thenAnswer((_) async =>  dartz.Left(ErrorAddingTask('unknow')));
        return AddTaskBloc(addTask: addTask,tasksStreamState:  tasksStreamState);
      },
      act: (bloc) => bloc.add(CreateTaskEvent(task)),
      expect: () => [SavingTaskState(),FailedToAddTaskState()],
      verify: (bloc) => {verify(() => addTask.call(task)).called(1)},
    );
  });
}
