import 'package:docketplus/models/task.dart';
import 'package:hive/hive.dart';

class Boxes {
  static Box<Task> getTasks() => Hive.box('usertasks');
}
