class Task {
  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.isDone,
    required this.createdAt,
    required this.updatedAt,
  });

  late String? id;
  late String title;
  late String description;
  late bool isDone;
  late DateTime createdAt;
  late DateTime updatedAt;

}
