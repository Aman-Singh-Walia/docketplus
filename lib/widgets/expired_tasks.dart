import 'package:docketplus/data/boxes.dart';
import 'package:docketplus/models/task.dart';
import 'package:docketplus/widgets/confirm_dialog.dart';
import 'package:docketplus/widgets/expired_item.dart';
import 'package:docketplus/widgets/no_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ExpiredTasks extends StatefulWidget {
  const ExpiredTasks({Key? key}) : super(key: key);

  @override
  State<ExpiredTasks> createState() => _ExpiredTasksState();
}

class _ExpiredTasksState extends State<ExpiredTasks> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<Task>>(
        valueListenable: Boxes.getTasks().listenable(),
        builder: ((context, box, _) {
          final expiredTasks = box.values
              .where((element) => element.to.isBefore(DateTime.now()))
              .toList()
              .cast<Task>();

          return expiredTasks.isEmpty
              ? const NoItem(msg: 'No Expired Tasks')
              : Stack(
                  children: [
                    ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: expiredTasks.length,
                        itemBuilder: (context, index) {
                          return ExpiredItem(task: expiredTasks[index]);
                        }),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          showConfirmDialog(
                              context,
                              'Delete All',
                              'Do you want to delete all expired tasks ?',
                              'Delete', () {
                            deleteAllExpired(expiredTasks);
                          });
                        },
                        icon: const Icon(CupertinoIcons.delete, size: 16.0),
                        label: const Text('Clear all',
                            style:
                                TextStyle(color: Colors.white, fontSize: 12.0)),
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

  Future deleteAllExpired(List<Task> allExpiredTasks) async {
    for (var item in allExpiredTasks) {
      item.delete();
    }
  } //delete all expired
}
