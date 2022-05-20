import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String groupVal = 'system';
  @override
  Widget build(BuildContext context) {
    final b = Hive.box('usertheme');
    groupVal = b.get('userChoiceTheme') ?? 'system';
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(CupertinoIcons.back),
          ),
          title: const Text('Settings')),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
            decoration: BoxDecoration(
                border: Border.all(width: 1.0, color: Colors.black12),
                borderRadius: BorderRadius.circular(15.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Theme',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontFamily: 'Varela',
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0),
                      ),
                      Icon(
                        groupVal == 'dark'
                            ? CupertinoIcons.moon_fill
                            : groupVal == 'light'
                                ? CupertinoIcons.brightness_solid
                                : CupertinoIcons.circle_lefthalf_fill,
                        size: 35.0,
                        color: CupertinoColors.activeBlue,
                      )
                    ],
                  ),
                ),
                RadioListTile<String>(
                    activeColor: CupertinoColors.activeBlue,
                    title: const Text(
                      'Dark',
                      style: TextStyle(
                          fontFamily: 'Varela', fontWeight: FontWeight.bold),
                    ),
                    value: 'dark',
                    groupValue: groupVal,
                    onChanged: (v) {
                      setState(() {
                        groupVal = v!;
                      });
                      final b = Hive.box('usertheme');
                      b.put('userChoiceTheme', 'dark');
                    }),
                RadioListTile<String>(
                    activeColor: CupertinoColors.activeBlue,
                    title: const Text(
                      'Light',
                      style: TextStyle(
                          fontFamily: 'Varela', fontWeight: FontWeight.bold),
                    ),
                    value: 'light',
                    groupValue: groupVal,
                    onChanged: (v) {
                      setState(() {
                        groupVal = v!;
                      });
                      final b = Hive.box('usertheme');
                      b.put('userChoiceTheme', 'light');
                    }),
                RadioListTile<String>(
                    activeColor: CupertinoColors.activeBlue,
                    title: const Text(
                      'System',
                      style: TextStyle(
                          fontFamily: 'Varela', fontWeight: FontWeight.bold),
                    ),
                    value: 'system',
                    groupValue: groupVal,
                    onChanged: (v) {
                      setState(() {
                        groupVal = v!;
                      });
                      final b = Hive.box('usertheme');
                      b.put('userChoiceTheme', 'system');
                    })
              ],
            ),
          )
        ],
      ),
    );
  }
}
