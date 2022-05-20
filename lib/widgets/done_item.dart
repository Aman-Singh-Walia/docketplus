import 'package:docketplus/models/task.dart';
import 'package:docketplus/provider/docket_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DoneItem extends StatefulWidget {
  final Task task;
  const DoneItem({Key? key, required this.task}) : super(key: key);

  @override
  State<DoneItem> createState() => _DoneItemState();
}

class _DoneItemState extends State<DoneItem> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DocketProvider>(
      context,
    );

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
    );
  }

  Future toggleDone(Task t) async {
    t.isDone = !t.isDone;
    t.save();
  } //mark as done
}
