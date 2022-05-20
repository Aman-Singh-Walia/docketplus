import 'package:docketplus/models/task.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpiredItem extends StatefulWidget {
  final Task task;
  const ExpiredItem({Key? key, required this.task}) : super(key: key);

  @override
  State<ExpiredItem> createState() => _ExpiredItemState();
}

class _ExpiredItemState extends State<ExpiredItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1.0, color: Colors.black12),
          borderRadius: BorderRadius.circular(15.0)),
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
              onPressed: () {},
              icon: const Icon(
                Icons.warning_rounded,
                color: CupertinoColors.systemRed,
              ))
        ],
      ),
    );
  }
}
