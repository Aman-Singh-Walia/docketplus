import 'package:docketplus/data/boxes.dart';
import 'package:docketplus/models/task.dart';
import 'package:docketplus/widgets/confirm_dialog.dart';

import 'package:docketplus/widgets/done_item.dart';
import 'package:docketplus/widgets/no_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DoneTasks extends StatefulWidget {
  const DoneTasks({Key? key}) : super(key: key);

  @override
  State<DoneTasks> createState() => _DoneTasksState();
}

class _DoneTasksState extends State<DoneTasks> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<Task>>(
        valueListenable: Boxes.getTasks().listenable(),
        builder: ((context, box, _) {
          final doneTasks = box.values
              .where((element) => element.isDone)
              .toList()
              .cast<Task>();

          return doneTasks.isEmpty
              ? const NoItem(msg: 'No Completed Tasks')
              : Stack(
                  children: [
                    ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: doneTasks.length,
                        itemBuilder: (context, index) {
                          return DoneItem(task: doneTasks[index]);
                        }),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          showConfirmDialog(
                              context,
                              'Delete All',
                              'Do you want to delete all completed tasks ?',
                              'Delete', () {
                            deleteAllCompleted(doneTasks);
                          });
                        },
                        icon: const Icon(
                          CupertinoIcons.delete,
                          size: 16.0,
                        ),
                        label: const Text(
                          'Clear all',
                          style: TextStyle(color: Colors.white, fontSize: 12.0),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                CupertinoColors.destructiveRed),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(15.0)))),
                      ),
                    )
                  ],
                );
        }));
  }

  Future deleteAllCompleted(List<Task> allCompletedTasks) async {
    for (var item in allCompletedTasks) {
      item.delete();
    }
  } //delete all completed
}
