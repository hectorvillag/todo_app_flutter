import 'package:todo_app_flutter/features/tasks_module/shared/domain/task.dart';

class TaskBuilder{
   String? _id;
   String _title = '';
   String _description = '';
   bool _isDone = false;

   Task build(){
      return Task(
        id:_id,
        title: _title,
        description: _description,
        isDone: _isDone,
      );
   }

   TaskBuilder withId(String? id){
      _id = id;
      return this;
   }

   TaskBuilder withTitle(String title){
    _title = title;
    return this;
   }

   TaskBuilder withDescription(String description){
    _description = description;
    return this;
   }
   TaskBuilder withIsDone(bool isDone){
    _isDone = isDone;
    return this;
   }

}