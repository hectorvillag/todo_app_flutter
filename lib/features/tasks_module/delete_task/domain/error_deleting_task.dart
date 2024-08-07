import 'package:todo_app_flutter/features/tasks_module/shared/domain/exceptions/task_exception.dart';


class ErrorDeletingTask extends TaskException{
  ErrorDeletingTask(super.message);

}