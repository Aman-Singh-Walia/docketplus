import 'package:docketplus/data/boxes.dart';
import 'package:docketplus/data/event_data_source.dart';
import 'package:docketplus/models/task.dart';
import 'package:docketplus/widgets/calender_view_task_item.dart';
import 'package:docketplus/widgets/no_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CalenderPage extends StatefulWidget {
  const CalenderPage({Key? key}) : super(key: key);

  @override
  State<CalenderPage> createState() => _CalenderPageState();
}

class _CalenderPageState extends State<CalenderPage> {
  DateTime selectedDate = DateTime.now();
  List months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  List<String> days = [
    'Sunday'
        'Monday'
        'Tuesday'
        'Wednesday'
        'Thursday'
        'Friday'
        'Saturday'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(CupertinoIcons.back),
          ),
          title: const Text('Calender'),
          centerTitle: true,
        ),
        body: ValueListenableBuilder<Box<Task>>(
            valueListenable: Boxes.getTasks().listenable(),
            builder: ((context, box, _) {
              final allTasks = box.values
                  .where((element) =>
                      !element.isDone && element.to.isAfter(DateTime.now()))
                  .toList()
                  .cast<Task>();

              final selectedDateTasks = box.values
                  .where((element) =>
                      element.from.day == selectedDate.day &&
                          element.from.month == selectedDate.month ||
                      element.to.day == selectedDate.day &&
                          element.to.month == selectedDate.month)
                  .toList()
                  .cast<Task>();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 1.0, color: Colors.black12)),
                    height: 400.0,
                    child: SfCalendar(
                      onTap: (details) {
                        setState(() {
                          selectedDate = details.date!;
                        });
                      },
                      headerStyle: const CalendarHeaderStyle(
                          textStyle: TextStyle(
                              fontFamily: 'SF',
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0)),
                      view: CalendarView.month,
                      initialSelectedDate: DateTime.now(),
                      dataSource: TaskDataSource(allTasks),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${months[selectedDate.month - 1]} ${selectedDate.day}',
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'SF',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: selectedDateTasks.isEmpty
                        ? const NoItem(msg: 'Not Tasks')
                        : SingleChildScrollView(
                            child: Column(
                                children: selectedDateTasks
                                    .map((e) => CalenderViewTaskItem(task: e))
                                    .toList()),
                          ),
                  ),
                ],
              );
            })));
  }
}
