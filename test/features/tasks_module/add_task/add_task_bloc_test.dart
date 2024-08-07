import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_app_flutter/features/tasks_module/add_task/domain/add_task.dart';
import 'package:todo_app_flutter/features/tasks_module/add_task/presentation/add_task_bloc/add_task_bloc.dart';
import 'package:todo_app_flutter/features/tasks_module/shared/domain/task.dart';
import 'package:todo_app_flutter/features/tasks_module/shared/domain/task_builder.dart';
import 'package:todo_app_flutter/shared/domain/nothing.dart';
import 'package:uuid/uuid.dart';

class MockAddTask extends Mock implements AddTask {}

main() {
  group('AddTaskBloc', () {
    late AddTask addTask;
    late Task task;
    Task createDummyTask() {
      TaskBuilder taskBuilder = TaskBuilder();
      taskBuilder.withId(const Uuid().v1());
      taskBuilder.withTitle('title');
      taskBuilder.withDescription('description');
      return taskBuilder.build();
    }

    setUp(() {
      addTask = MockAddTask();
      task = createDummyTask();
    });
    
    blocTest(
      'emits AddTaskSuccessState when CreateTaskEvent is added',
      build: () {
        when(() => addTask.call(task))
            .thenAnswer((_) async => const dartz.Right(Nothing()));
        return AddTaskBloc(addTask: addTask);
      },
      act: (bloc) => bloc.add(CreateTaskEvent(task)),
      expect: () => [SavingTaskState(),AddTaskSuccessState()],
      verify: (bloc) => {verify(() => addTask.call(task)).called(1)},
    );

    blocTest(
      'emits FailedToAddTaskState when CreateTaskEvent is added',
      build: () {
        when(() => addTask.call(task))
            .thenAnswer((_) async =>  dartz.Left(Exception('unknow')));
        return AddTaskBloc(addTask: addTask);
      },
      act: (bloc) => bloc.add(CreateTaskEvent(task)),
      expect: () => [SavingTaskState(),FailedToAddTaskState()],
      verify: (bloc) => {verify(() => addTask.call(task)).called(1)},
    );
  });
}
