import 'package:docketplus/animations/page_transition.dart';
import 'package:docketplus/pages/add_task_page.dart';
import 'package:docketplus/pages/calender_page.dart';
import 'package:docketplus/pages/settings_page.dart';
import 'package:docketplus/provider/docket_provider.dart';
import 'package:docketplus/services/notification_api.dart';
import 'package:docketplus/widgets/all_tasks.dart';
import 'package:docketplus/widgets/confirm_dialog.dart';
import 'package:docketplus/widgets/done_tasks.dart';
import 'package:docketplus/widgets/expired_tasks.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    NotificationApi.init();
  }

  int tabIndex = 0;
  final screens = const [AllTasks(), DoneTasks(), ExpiredTasks()];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DocketProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Docket'),
        actions: [
          Visibility(
            visible: provider.multiSelection ? false : true,
            child: IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(CustomPageRoute(child: const SettingsPage()));
                },
                icon: const Icon(Icons.settings)),
          ),
          Visibility(
            visible: provider.multiSelection ? false : true,
            child: IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(CustomPageRoute(child: const CalenderPage()));
                },
                icon: const Icon(Icons.calendar_month)),
          ),
          Visibility(
            visible: provider.multiSelection ? false : true,
            child: IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(CustomPageRoute(child: const AddTaskPage()));
                },
                icon: const Icon(CupertinoIcons.add)),
          ),
          Visibility(
              visible: provider.multiSelection,
              child: Text(
                '${provider.selectedTasks.length}',
                textAlign: TextAlign.center,
              )),
          Visibility(
              visible: provider.multiSelection,
              child: IconButton(
                  onPressed: () {
                    showConfirmDialog(
                        context,
                        'Delete',
                        'Do you want to delete selected tasks ?',
                        'Delete',
                        provider.deleteSelected);
                  },
                  icon: const Icon(CupertinoIcons.delete))),
          Visibility(
              visible: provider.multiSelection,
              child: IconButton(
                  onPressed: () {
                    provider.selectedTasks = [];
                    provider.updateUi();
                  },
                  icon: const Icon(CupertinoIcons.clear)))
        ],
      ),
      body: Container(
          padding: const EdgeInsets.fromLTRB(3.0, 8.0, 3.0, 0.0),
          child: screens[tabIndex]),
      bottomNavigationBar: Visibility(
          visible: provider.multiSelection ? false : true,
          child: BottomNavigationBar(
            onTap: (v) {
              setState(() {
                tabIndex = v;
              });
            },
            currentIndex: tabIndex,
            selectedItemColor: CupertinoColors.activeBlue,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_month), label: 'Tasks'),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.checkmark_alt_circle_fill),
                  label: 'Done'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.warning_rounded), label: 'Expired'),
            ],
          )),
    );
  }
}
