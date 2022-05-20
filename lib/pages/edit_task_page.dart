import 'package:date_field/date_field.dart';
import 'package:docketplus/models/task.dart';
import 'package:docketplus/services/notification_api.dart';
import 'package:docketplus/widgets/alert_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditTaskPage extends StatefulWidget {
  final Task currentTask;
  const EditTaskPage({Key? key, required this.currentTask}) : super(key: key);

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  bool remindChoice = false;
  TextEditingController iconControl = TextEditingController();
  TextEditingController taskControl = TextEditingController();

  DateTime defaultTo = DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day, DateTime.now().hour + 2, DateTime.now().minute);

  DateTime defaultFrom = DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day, DateTime.now().hour, DateTime.now().minute);

  DateTime defaultRemindOn = DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day, DateTime.now().hour + 1, DateTime.now().minute);
  @override
  Widget build(BuildContext context) {
    remindChoice = widget.currentTask.remind;
    iconControl.text = widget.currentTask.icon;
    taskControl.text = widget.currentTask.task;
    defaultTo = widget.currentTask.to;
    defaultFrom = widget.currentTask.from;
    defaultRemindOn = widget.currentTask.remindOn;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(CupertinoIcons.back),
        ),
        title: const Text('Edit task'),
        actions: [
          IconButton(
              onPressed: () {
                if (defaultRemindOn.isBefore(DateTime.now())) {
                  showAlertDialog(context, 'Alert',
                      'Can`t set schedule for selected time', 'Close');
                } else if (taskControl.text == '') {
                  showAlertDialog(
                      context, 'Alert', 'Can`t save empty task', 'Close');
                } else if (remindChoice) {
                  editTask(
                      widget.currentTask,
                      taskControl.text,
                      iconControl.text == '' ? '💙' : iconControl.text,
                      false,
                      false,
                      remindChoice,
                      defaultRemindOn,
                      defaultFrom,
                      defaultTo);
                  NotificationApi.showScheduledNotification(
                      id: widget.currentTask.scheduleId,
                      title: 'Task',
                      body: widget.currentTask.task,
                      scheduleDate: defaultRemindOn);
                  Navigator.pop(context);
                } else {
                  editTask(
                      widget.currentTask,
                      taskControl.text,
                      iconControl.text == '' ? '💙' : iconControl.text,
                      false,
                      false,
                      remindChoice,
                      defaultRemindOn,
                      defaultFrom,
                      defaultTo);
                  NotificationApi.removeSchedules(
                      widget.currentTask.scheduleId);
                  Navigator.pop(context);
                }
              },
              icon: const Icon(CupertinoIcons.checkmark_alt))
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
            child: SizedBox(
              width: 100,
              height: 100,
              child: TextField(
                controller: iconControl,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(
                      '(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])'))
                ],
                textAlign: TextAlign.center,
                maxLength: 1,
                showCursor: false,
                decoration: const InputDecoration(
                  counter: Offstage(),
                  border: InputBorder.none,
                ),
                style: const TextStyle(
                  fontSize: 60.0,
                ),
              ),
            ),
          ),
          Card(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextField(
                      style: const TextStyle(fontFamily: 'Varela'),
                      textCapitalization: TextCapitalization.sentences,
                      controller: taskControl,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      minLines: 8,
                      maxLines: 8,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Task',
                        labelStyle: TextStyle(
                          fontFamily: 'Varela',
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          //task date from and date to________________________________
          Card(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Period',
                          style: TextStyle(
                              fontFamily: 'SF',
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0),
                        ),
                        Icon(Icons.calendar_month)
                      ],
                    ),
                  ),
                  //task date from_________________________________________
                  DateTimeFormField(
                    initialDate: defaultFrom,
                    initialValue: defaultFrom,
                    firstDate: DateTime.now(),
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(color: Colors.blue),
                      errorStyle: TextStyle(color: Colors.redAccent),
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(
                        Icons.event_note,
                      ),
                      labelText: 'From',
                    ),
                    mode: DateTimeFieldPickerMode.dateAndTime,
                    autovalidateMode: AutovalidateMode.always,
                    onDateSelected: (DateTime value) {
                      defaultFrom = value;
                    },
                  ),
                  //divider________________________________________________________
                  const Divider(
                    thickness: 1.0,
                    height: 40.0,
                  ),
                  //task date to_________________________________________
                  DateTimeFormField(
                    initialDate: defaultTo,
                    initialValue: defaultTo,
                    firstDate: DateTime.now(),
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(color: Colors.blue),
                      errorStyle: TextStyle(color: Colors.redAccent),
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(
                        Icons.event_note,
                      ),
                      labelText: 'To',
                    ),
                    mode: DateTimeFieldPickerMode.dateAndTime,
                    autovalidateMode: AutovalidateMode.always,
                    onDateSelected: (DateTime value) {
                      defaultTo = value;
                    },
                  ),
                ],
              ),
            ),
          ),
          //reminder date time___________________________________________
          Card(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
            child: Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Reminder',
                            style: TextStyle(
                                fontFamily: 'SF',
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                          ),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  widget.currentTask.task = taskControl.text;
                                  widget.currentTask.icon = iconControl.text;
                                  widget.currentTask.remindOn = defaultRemindOn;
                                  widget.currentTask.from = defaultFrom;
                                  widget.currentTask.to = defaultTo;
                                  widget.currentTask.remind =
                                      !widget.currentTask.remind;
                                });
                              },
                              icon: Icon(remindChoice
                                  ? Icons.notifications_active
                                  : Icons.notifications_off)),
                        ],
                      ),
                    ),
                    //reminder date time___________________________________________
                    DateTimeFormField(
                      initialDate: defaultRemindOn,
                      initialValue: defaultRemindOn,
                      firstDate: DateTime.now(),
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(color: Colors.blue),
                        errorStyle: TextStyle(color: Colors.redAccent),
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(
                          Icons.notification_add,
                        ),
                        labelText: 'Remind On',
                      ),
                      mode: DateTimeFieldPickerMode.dateAndTime,
                      autovalidateMode: AutovalidateMode.always,
                      onDateSelected: (DateTime value) {
                        defaultRemindOn = value;
                      },
                    ),
                  ],
                )),
          )
        ],
      )),
    );
  }

  Future editTask(Task t, String task, String icon, bool isDone, bool isAllDay,
      bool remind, DateTime remindOn, DateTime from, DateTime to) async {
    t.task = task;
    t.icon = icon;
    t.isDone = isDone;
    t.isAllDay = isAllDay;
    t.remind = remind;
    t.remindOn = remindOn;
    t.from = from;
    t.to = to;
    t.save();
  } //edit task
}
