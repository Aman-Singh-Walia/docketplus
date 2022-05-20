import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  late int scheduleId;

  @HiveField(1)
  late String task;

  @HiveField(2)
  late String icon;

  @HiveField(3)
  late bool isDone;

  @HiveField(4)
  late bool isAllDay;

  @HiveField(5)
  late bool remind;

  @HiveField(6)
  late DateTime remindOn;

  @HiveField(7)
  late DateTime from;

  @HiveField(8)
  late DateTime to;
}
