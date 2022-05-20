import 'package:docketplus/models/task.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewTaskPage extends StatefulWidget {
  final Task openedTask;
  const ViewTaskPage({Key? key, required this.openedTask}) : super(key: key);

  @override
  State<ViewTaskPage> createState() => _ViewTaskPageState();
}

class _ViewTaskPageState extends State<ViewTaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding: const EdgeInsets.all(5.0),
                      margin: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(width: 1.0, color: Colors.black12),
                          color: Colors.transparent),
                      child: Text(
                        widget.openedTask.icon,
                        style: const TextStyle(fontSize: 40.0),
                      )),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        CupertinoIcons.clear,
                      )),
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
                    'From : ${widget.openedTask.from.day}-${widget.openedTask.from.month}-${widget.openedTask.from.year}',
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
                    'To : ${widget.openedTask.to.day}-${widget.openedTask.to.month}-${widget.openedTask.to.year}',
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
                        widget.openedTask.remind
                            ? Icons.notifications_active
                            : Icons.notifications_off,
                        color: CupertinoColors.activeBlue,
                      )),
                  Text(
                      'Remind On : ${widget.openedTask.remindOn.day}-${widget.openedTask.remindOn.month}-${widget.openedTask.remindOn.year}'),
                ],
              ),
              const Divider(),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Text(
                    widget.openedTask.task,
                    style: const TextStyle(fontFamily: 'SF', fontSize: 20.0),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
