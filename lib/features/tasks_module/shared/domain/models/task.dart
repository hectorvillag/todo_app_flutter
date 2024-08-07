class Task {
  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.isDone,
  });

  late int? id;
  late String title;
  late String description;
  late bool isDone;

}
