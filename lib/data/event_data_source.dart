import 'package:docketplus/models/task.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class TaskDataSource extends CalendarDataSource {
  TaskDataSource(List<Task> appointments) {
    this.appointments = appointments;
  }

  Task getEvent(int index) => appointments![index] as Task;

  @override
  DateTime getStartTime(int index) => getEvent(index).from;

  @override
  DateTime getEndTime(int index) => getEvent(index).to;

  @override
  String getSubject(int index) => getEvent(index).task;
}
