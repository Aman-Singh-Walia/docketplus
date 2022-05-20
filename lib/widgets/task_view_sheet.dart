import 'package:docketplus/models/task.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showTaskViewSheet(BuildContext context, Task opendTask) {
  showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15.0))),
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      padding: const EdgeInsets.all(5.0),
                      margin: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(width: 1.0, color: Colors.black12),
                          color: Colors.transparent),
                      child: Text(
                        opendTask.icon,
                        style: const TextStyle(fontSize: 40.0),
                      )),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(CupertinoIcons.clear))
                ],
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.calendar_today,
                        color: CupertinoColors.activeGreen,
                      )),
                  Text(
                    'From : ${opendTask.from.day}-${opendTask.from.month}-${opendTask.from.year}',
                    style: const TextStyle(
                      fontFamily: 'SF',
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.calendar_today,
                        color: CupertinoColors.systemRed,
                      )),
                  Text(
                    'To : ${opendTask.to.day}-${opendTask.to.month}-${opendTask.to.year}',
                    style: const TextStyle(
                      fontFamily: 'SF',
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        opendTask.remind
                            ? Icons.notifications_active
                            : Icons.notifications_off,
                        color: CupertinoColors.activeBlue,
                      )),
                  Text(
                      'Reminder : ${opendTask.remindOn.day}-${opendTask.remindOn.month}-${opendTask.remindOn.year} ${opendTask.remindOn.hour}:${opendTask.remindOn.minute}'),
                ],
              ),
              const Divider(),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Text(
                    opendTask.task,
                    style: const TextStyle(fontFamily: 'SF', fontSize: 20.0),
                  ),
                ),
              )
            ],
          ),
        );
      });
}
