import 'package:hive/hive.dart';

part 'task_dto.g.dart';

@HiveType(typeId: 0)
class TaskDTO {

  @HiveField(0)
  String title;

  @HiveField(1)
  String description;

  @HiveField(2)
  bool isDone;

  TaskDTO({
    required this.title,
    required this.description,
    required this.isDone,
  });
}
