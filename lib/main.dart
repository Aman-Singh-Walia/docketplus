import 'package:docketplus/models/task.dart';
import 'package:docketplus/pages/home_page.dart';
import 'package:docketplus/provider/docket_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>('usertasks');
  await Hive.openBox('usertheme');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box('usertheme').listenable(),
        builder: ((context, box, _) {
          final b = Hive.box('usertheme');
          final storedTheme = b.get('userChoiceTheme');
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(
                  create: (BuildContext context) => DocketProvider()),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              themeMode: storedTheme == 'dark'
                  ? ThemeMode.dark
                  : storedTheme == 'light'
                      ? ThemeMode.light
                      : ThemeMode.system,
              theme: ThemeData(
                appBarTheme: const AppBarTheme(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(15.0))),
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.transparent,
                      statusBarIconBrightness: Brightness.light,
                    ),
                    backgroundColor: CupertinoColors.systemBlue,
                    elevation: 0.0,
                    titleTextStyle: TextStyle(
                        fontFamily: 'SF',
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0)),
              ),
              darkTheme: ThemeData(
                colorScheme: const ColorScheme.dark(primary: Colors.blue),
                appBarTheme: const AppBarTheme(
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Colors.transparent,
                        statusBarIconBrightness: Brightness.light),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(15.0))),
                    elevation: 0.0,
                    titleTextStyle: TextStyle(
                        fontFamily: 'SF',
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0)),
                primaryColor: CupertinoColors.activeBlue,
              ),
              home: const HomePage(),
            ),
          );
        }));
  }
}
