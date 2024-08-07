import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_app_flutter/features/logger/app_logger.dart';
import 'package:todo_app_flutter/features/tasks_module/add_task/domain/add_task.dart';
import 'package:todo_app_flutter/features/tasks_module/shared/domain/task.dart';
import 'package:todo_app_flutter/features/tasks_module/shared/domain/task_builder.dart';
import 'package:todo_app_flutter/features/tasks_module/shared/domain/task_repository.dart';
import 'package:uuid/uuid.dart';

class MockTaskRepository extends Mock implements TaskRepository {}

class MockAppLogger extends Mock implements AppLogger {}

void main() {
  group('AddTasks', () {
    late TaskRepository taskRepository;
    late AppLogger appLogger;

    Task createDummyTask() {
      TaskBuilder taskBuilder = TaskBuilder();
      taskBuilder.withId(const Uuid().v1());
      taskBuilder.withTitle('title');
      taskBuilder.withDescription('description');
      return taskBuilder.build();
    }

    setUp(() {
      taskRepository = MockTaskRepository();
      appLogger = MockAppLogger();
    });

    test('add task [success]', () async {
      //Arrange
      Task task = createDummyTask();

      when(() => taskRepository.add(task)).thenAnswer((_) async {return task;});

      AddTask addTask = AddTask(taskRepository, appLogger);

      //Act
      var result = await addTask.call(task);

      //Assert
      expect(result, isA<dartz.Right>());
      verify(()=> taskRepository.add(task)).called(1);
    });

    test('add task [fail]', () async {
      //Arrange
      Task task = createDummyTask();

      when(() => taskRepository.add(task)).thenThrow(Exception('unknow'));
      
      AddTask addTask = AddTask(taskRepository, appLogger);

      //Act
      var result = await addTask.call(task);

      //Assert
      expect(result, isA<dartz.Left>());
      verify(()=> taskRepository.add(task)).called(1);
      verify(()=> appLogger.error(any(),error: any(named: 'error'))).called(1);
    });
  });
}
