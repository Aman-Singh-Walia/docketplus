import 'package:badges/badges.dart';
import 'package:docketplus/animations/page_transition.dart';
import 'package:docketplus/models/task.dart';
import 'package:docketplus/pages/edit_task_page.dart';
import 'package:docketplus/provider/docket_provider.dart';
import 'package:docketplus/services/notification_api.dart';
import 'package:docketplus/widgets/task_view_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class TaskItem extends StatefulWidget {
  final Task task;
  const TaskItem({Key? key, required this.task}) : super(key: key);

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DocketProvider>(
      context,
    );
    selected = provider.selectedTasks.contains(widget.task);
    return Badge(
      toAnimate: false,
      showBadge: widget.task.remind,
      elevation: 5.0,
      badgeContent: const Icon(
        Icons.notifications_active,
        size: 12.0,
        color: Colors.white,
      ),
      badgeColor: CupertinoColors.activeBlue,
      position: BadgePosition.topStart(start: 1.0, top: 1.0),
      child: Card(
        elevation: 0.0,
        clipBehavior: Clip.hardEdge,
        color: selected ? Colors.blue.withAlpha(50) : null,
        shape: RoundedRectangleBorder(
            side: BorderSide(
                width: 1.0,
                color: !selected ? Colors.black12 : CupertinoColors.activeBlue),
            borderRadius: BorderRadius.circular(15.0)),
        child: InkWell(
          onLongPress: provider.multiSelection
              ? null
              : () {
                  showTaskViewSheet(context, widget.task);
                },
          onTap: provider.multiSelection
              ? null
              : () {
                  Navigator.of(context).push(CustomPageRoute(
                      child: EditTaskPage(
                    currentTask: widget.task,
                  )));
                },
          focusColor: CupertinoColors.activeBlue.withAlpha(50),
          hoverColor: CupertinoColors.activeBlue.withAlpha(50),
          highlightColor: CupertinoColors.activeBlue.withAlpha(50),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  if (provider.selectedTasks.contains(widget.task)) {
                    setState(() {
                      provider.selectedTasks.remove(widget.task);
                      provider.updateUi();
                    });
                  } else {
                    setState(() {
                      provider.selectedTasks.add(widget.task);
                      provider.updateUi();
                    });
                  }
                },
                child: Container(
                    padding: const EdgeInsets.all(5.0),
                    margin: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(
                            width: 1.0,
                            color: !selected
                                ? Colors.black12
                                : CupertinoColors.activeBlue),
                        color: Colors.transparent),
                    child: Text(
                      widget.task.icon,
                      style: const TextStyle(fontSize: 40.0),
                    )),
              ),
              Expanded(
                child: Text(
                  widget.task.task,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  maxLines: 2,
                  style: const TextStyle(fontFamily: 'SF', fontSize: 17.0),
                ),
              ),
              IconButton(
                  onPressed: provider.multiSelection
                      ? null
                      : () {
                          toggleDone(widget.task);
                        },
                  icon: widget.task.isDone
                      ? const Icon(
                          CupertinoIcons.checkmark_alt_circle_fill,
                          color: CupertinoColors.activeGreen,
                        )
                      : const Icon(CupertinoIcons.circle))
            ],
          ),
        ),
      ),
    );
  }

  Future toggleDone(Task t) async {
    if (t.remind) {
      NotificationApi.removeSchedules(t.scheduleId);
      t.remind = false;
    }
    t.isDone = !t.isDone;
    t.save();
  } //mark as done
}
