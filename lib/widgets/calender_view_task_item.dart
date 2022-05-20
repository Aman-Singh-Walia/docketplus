import 'package:badges/badges.dart';
import 'package:docketplus/animations/page_transition.dart';

import 'package:docketplus/models/task.dart';
import 'package:docketplus/pages/edit_task_page.dart';
import 'package:docketplus/widgets/task_view_sheet.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CalenderViewTaskItem extends StatefulWidget {
  final Task task;
  const CalenderViewTaskItem({Key? key, required this.task}) : super(key: key);

  @override
  State<CalenderViewTaskItem> createState() => _CalenderViewTaskItemState();
}

class _CalenderViewTaskItemState extends State<CalenderViewTaskItem> {
  @override
  Widget build(BuildContext context) {
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
        clipBehavior: Clip.hardEdge,
        elevation: 0.0,
        shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1.0, color: Colors.black12),
            borderRadius: BorderRadius.circular(15.0)),
        child: InkWell(
          onLongPress: () {
            showTaskViewSheet(context, widget.task);
          },
          onTap: () {
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
              Container(
                  padding: const EdgeInsets.all(5.0),
                  margin: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(width: 1.0, color: Colors.black12),
                      color: Colors.transparent),
                  child: Text(
                    widget.task.icon,
                    style: const TextStyle(fontSize: 40.0),
                  )),
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
                  onPressed: () {
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
    t.isDone = !t.isDone;
    t.save();
  } //mark as done
}
