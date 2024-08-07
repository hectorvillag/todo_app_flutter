import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_flutter/features/tasks_module/shared/domain/task_builder.dart';
import 'package:todo_app_flutter/features/tasks_module/add_task/presentation/add_task_bloc/add_task_bloc.dart';

import '../../shared/domain/task.dart';

class AddTaskForm extends StatefulWidget {
  const AddTaskForm({super.key});

  @override
  State<AddTaskForm> createState() => _AddTaskFormState();
}

class _AddTaskFormState extends State<AddTaskForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Título'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'El título es requerido';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 12,
          ),
          TextFormField(
            controller: _descriptionController,
            decoration:
                const InputDecoration(labelText: 'Descripción (opcional)'),
            maxLines: 3,
          ),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: EdgeInsets.only(
                left: 12.0,
                right: 12.0,
                bottom: MediaQuery.maybePaddingOf(context)?.bottom ?? 0.0),
            child: SizedBox(
              width: double.infinity,
              height: 48.0,
              child: ElevatedButton(
                onPressed: submit,
                child: const Text('Crear'),
              ),
            ),
          )
        ],
      ),
    );
  }

  void submit() {
    if (_formKey.currentState!.validate()) {
      final task = createTask();
      BlocProvider.of<AddTaskBloc>(context).add(CreateTaskEvent(task));
    }
  }

  Task createTask() {
    TaskBuilder taskBuilder = TaskBuilder();
    taskBuilder.withTitle(_titleController.text);
    if (_descriptionController.text.isNotEmpty) {
      taskBuilder.withDescription(_descriptionController.text);
    }
    return taskBuilder.build();
  }
}
