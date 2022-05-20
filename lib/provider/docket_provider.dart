import 'package:docketplus/models/task.dart';
import 'package:docketplus/services/notification_api.dart';
import 'package:flutter/cupertino.dart';

class DocketProvider extends ChangeNotifier {
  List<Task> searchTaskList = [];
  List<Task> selectedTasks = [];
  List<Task> allCompletedTasks = [];
  List<Task> allExpiredTasks = [];

  bool get multiSelection => selectedTasks.isEmpty ? false : true;

  Future deleteSelected() async {
    for (var item in selectedTasks) {
      if (item.remind) {
        NotificationApi.removeSchedules(item.scheduleId);
        item.delete();
      } else {
        item.delete();
      }
    }
    selectedTasks = [];
    notifyListeners();
  } //delete selected

  Future deleteAllCompleted() async {
    for (var item in allCompletedTasks) {
      item.delete();
    }
  } //delete all completed

  Future deleteAllExpired() async {
    for (var item in allExpiredTasks) {
      item.delete();
    }
  } //delete all expired

  updateUi() {
    notifyListeners();
  } //update ui

}
