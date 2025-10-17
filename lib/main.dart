import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskmate/classes/task_class.dart';
import 'package:taskmate/classes/task_provider.dart';
import 'package:taskmate/classes/theme_class.dart';
import 'package:taskmate/pages/home.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  // ignore: unused_local_variable
  final String localTimeZone = await AwesomeNotifications()
      .getLocalTimeZoneIdentifier();
  await AwesomeNotifications().initialize("resource://drawable/notification_icon", [
    NotificationChannel(
      channelKey: "task_channel",
      channelName: "Task Reminder",
      channelDescription: "Do your task",
      defaultColor: Colors.blue,
      importance: NotificationImportance.High,
      channelShowBadge: true,
    ),
  ]);

  await Hive.initFlutter();
  Hive.registerAdapter(TaskClassAdapter());

  await Hive.openBox<TaskClass>("box");
  await Hive.openBox<TaskClass>("historyTaskBox");
  // await SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitDown,
  //   DeviceOrientation.portraitUp,
  // ]);

  runApp(
    ChangeNotifierProvider(create: (context) => TaskProvider(), child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightMode,
      darkTheme: darkMode,

      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
