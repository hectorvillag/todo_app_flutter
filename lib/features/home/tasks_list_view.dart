import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_flutter/features/home/home_task_item.dart';
import 'package:todo_app_flutter/features/tasks_module/shared/domain/models/task.dart';

enum FilterType { all, done, notDone }

class TasksListView extends StatefulWidget {
  const TasksListView({
    super.key,
    required this.tasks,
  });

  final List<Task> tasks;

  @override
  State<TasksListView> createState() => _TasksListViewState();
}

class _TasksListViewState extends State<TasksListView> {
  late FilterType _filterType;

  @override
  void initState() {
    super.initState();
    _filterType = FilterType.all;
  }

  @override
  Widget build(BuildContext context) {
    if(widget.tasks.isEmpty){
      return  Center(child: Text('Sin tareas!',style: Theme.of(context).textTheme.bodyLarge,));
    }
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: ListView(
          children: [
            DropdownButtonHideUnderline(
              child: DropdownButton2<FilterType>(
                isExpanded: true,
                hint: Text(
                  'Filtros',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).hintColor,
                  ),
                ),
                items: FilterType.values
                    .map((FilterType item) => DropdownMenuItem<FilterType>(
                          value: item,
                          child: Text(
                            getFilterName(item),
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ))
                    .toList(),
                value: _filterType,
                onChanged: (FilterType? value) {
                  if (value != null) {
                    setState(() {
                      _filterType = value;
                    });
                  }
                },
                buttonStyleData: const ButtonStyleData(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  height: 40,
                  width: 140,
                ),
                menuItemStyleData: const MenuItemStyleData(
                  height: 40,
                ),
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            ..._filteredList(_filterType, widget.tasks)
                .map((task) => HomeTaskItem(task: task)),
          ],
        ));
  }

  List<Task> _filteredList(FilterType filterType, List<Task> tasks) {
    switch (filterType) {
      case FilterType.all:
        return tasks;
      case FilterType.done:
        return tasks.where((task) => task.isDone).toList();
      case FilterType.notDone:
        return tasks.where((task) => !task.isDone).toList();
    }
  }

  String getFilterName(FilterType filterType) {
    switch (filterType) {
      case FilterType.all:
        return "Todos";
      case FilterType.done:
        return "Completados";
      case FilterType.notDone:
        return "No completados";
    }
  }
}
