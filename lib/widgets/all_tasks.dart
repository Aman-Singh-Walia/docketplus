import 'package:docketplus/data/boxes.dart';
import 'package:docketplus/models/task.dart';
import 'package:docketplus/widgets/no_item.dart';
import 'package:docketplus/widgets/task_item.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AllTasks extends StatefulWidget {
  const AllTasks({Key? key}) : super(key: key);

  @override
  State<AllTasks> createState() => _AllTasksState();
}

class _AllTasksState extends State<AllTasks> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<Task>>(
        valueListenable: Boxes.getTasks().listenable(),
        builder: ((context, box, _) {
          final allTasks = box.values
              .where((element) =>
                  !element.isDone && element.to.isAfter(DateTime.now()))
              .toList()
              .cast<Task>();

          return allTasks.isEmpty
              ? const NoItem(msg: 'No Tasks')
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: allTasks.length,
                  itemBuilder: (context, index) {
                    return TaskItem(task: allTasks[index]);
                  });
        }));
  }
}
