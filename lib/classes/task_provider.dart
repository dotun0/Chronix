// ignore_for_file: deprecated_member_us, use_build_context_synchronously, unused_local_variable

import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:taskmate/classes/task_class.dart';
import 'package:taskmate/classes/theme_class.dart';
import 'package:taskmate/pages/home.dart';
import 'package:taskmate/pages/task_input.dart';
import 'package:uuid/uuid.dart';

class TaskProvider extends ChangeNotifier {
  //User Information Box
  final userInfo = Hive.box("userInfo");
  //Box get userinfo => userInfo;
  TextEditingController userInputName = TextEditingController();
  String get userName => userInfo.get("userName");
  void updateName(TextEditingController name, BuildContext context) {
    if (name.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: appColor,

          behavior: SnackBarBehavior.fixed,
          content: Text(
            "Please input your name, it's for personalization purpose",
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
        ),
      );
    } else {
      userInfo.put("userName", userInputName.text);
      //userName is read from the Hive box via the getter
      Navigator.pop(context);
      //Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    }
  }

  //Color of the app color
  Color appColor = const Color(0xFF2048ff);

  //TextEditingController for the task text inputted in the input page
  TextEditingController inputTask = TextEditingController();
  // The boss Hive box to save the tasks to device
  final box = Hive.box<TaskClass>("box");
  final historyBox = Hive.box<TaskClass>("historyTaskBox");
  List<TaskClass> get taskList => box.values.toList().reversed.toList();
  //Function to check the box for each task
  void onCheckFunction(String id, TaskClass? updatedTask) {
    try {
      final newBox = box.get(id);
      newBox!.taskState = true;
      box.put(id, updatedTask!);

      // final newHistoryBox = historyBox.get(id);
      // newHistoryBox!.taskState = true;
      // historyBox.put(id, updatedTask);
      notifyListeners();
    } catch (e) {
      debugPrint("Error checking your task, close the app and try again");
    }
  }

  void onHistoryCheckFunction(String id, TaskClass? updatedTask) {
    try {
      final newHistoryBox = historyBox.get(id);
      newHistoryBox!.taskState = true;
      historyBox.put(id, updatedTask!);
      notifyListeners();
    } catch (e) {
      debugPrint("Error checking your task, close the app and try again");
    }
  }

  //Function to delete a task from the box
  void onDelete(String id) async {
    try {
      await box.delete(id);
      notifyListeners();
    } catch (e) {
      debugPrint("Error deleting your task, close app and try again");
    }
  }

  //Function to add task to the box with newTask passed as a parameter
  void onAdd(
    TaskClass newTask,
    BuildContext context,
    String initialId,
    String message,
  ) async {
    try {
      if (inputTask.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            backgroundColor: appColor,
            //margin: EdgeInsets.all(20),
            behavior: SnackBarBehavior.fixed,
            duration: Duration(milliseconds: 800),
            content: Text(
              "Please input your task",
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).textTheme.bodyLarge!.color!,
              ),
            ),
          ),
        );
      } else {
        await box.put(initialId, newTask);

        await historyBox.put(initialId, newTask.clone());
        Navigator.pop(context);

        scheduleNotification(newTask, todTodt(newTime));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: appColor,
            // margin: EdgeInsets.all(20),
            behavior: SnackBarBehavior.fixed,
            content: Text(
              "${inputTask.text} was $message for ${newTime.format(context)}",
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
          ),
        );
        inputTask.clear();
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Error adding your task, please close and try again");
    }
  }

  //Category and category function for the category buttons feature
  String _cat = "All";

  String get cat => _cat;
  set cat(String value) {
    _cat = value;
    notifyListeners();
  }

  //List of categories to be shown in the drop down
  List categories = ["Work", "Personal", "Education", "Projects", "Others"];
  String newCategory = "Work";
  //Function to setCategory from the dropdown menu and to assign color base on your selection
  void setCategory(String value) {
    newCategory = value;
    if (newCategory == "Work") {
      catColor = Colors.red.value;
    } else if (newCategory == "Personal") {
      catColor = Colors.purple.value;
    } else if (newCategory == "Education") {
      catColor = Colors.blue.value;
    } else if (newCategory == "Projects") {
      catColor = Colors.orange.value;
    } else if (newCategory == "Others") {
      catColor = Colors.green.value;
    }
    notifyListeners();
  }

  int catColor = Colors.red.value;
  //Function for the filtered tasks according to category
  List<TaskClass> get filteredTask {
    if (cat == "All") {
      return box.toMap().values.toList();
    } else {
      return box.values.where((test) => test.taskCategory == _cat).toList();
    }
  }

  // bool historyState = true;
  List<TaskClass> get doneHistoryTask {
    return historyBox.values.where((tests) => tests.taskState == true).toList();
  }

  List<TaskClass> get undoneHistoryTask {
    return historyBox.values
        .where((tests) => tests.taskState == false)
        .toList();
  }

  //Function for the timePicker
  TimeOfDay newTime = TimeOfDay.now();
  void setTime(TimeOfDay period, TaskClass newTask) {
    newTime = period;

    notifyListeners();
  }

  var uuid = Uuid();
  //Function to convert TimeOfDay to DateTime to be used from timePicker to notification
  DateTime todTodt(TimeOfDay tod) {
    return DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      tod.hour,
      tod.minute,
    );
  }

  // Function to convert DateTime to TimeOfDay
  TimeOfDay dtTotod(DateTime dt) {
    return TimeOfDay(hour: dt.hour, minute: dt.minute);
  }

  List specificMessage() {
    final now = DateTime.now();
    final day = now.weekday;
    final random = Random();
    List<List<String>> messages = [
       [
          "most there $userName 🫡🫡",
          "Plan now so we can celebrate the win on weekend",
        ],
    ];
    // List<List<String>> messages = [[
    //       "It's the weekenddd !!!!🥳🥳",
    //       "Rest and reflect on your week boss 🫡🫡",
    //     ],
    //     [
    //       "It's finally Friday 🥳🥳 ",
    //       "You deserve the rest you are about to have $userName",
    //     ],
    //     [
    //       "Relax boss, you've earned it 🫡🫡",
    //       "Let's utilize the weekend to refill",
    //     ],
    //     [
    //       "Congratulations, it's the weekend 😄😄",
    //       "You deserve the rest you are about to have $userName",
    //     ],
    //     [
    //       "It's finally Friday 🥳🥳",
    //       "You deserve the rest you are about to have $userName",
    //     ],];
    // For friday evening
    if (day == 5) {
      List<List> messages = [
        [
          "It's the weekenddd !!!!🥳🥳",
          "Rest and reflect on your week boss 🫡🫡",
        ],
        [
          "It's finally Friday 🥳🥳 ",
          "You deserve the rest you are about to have $userName",
        ],
        [
          "Relax boss, you've earned it 🫡🫡",
          "Let's utilize the weekend to refill",
        ],
        [
          "Congratulations, it's the weekend 😄😄",
          "You deserve the rest you are about to have $userName",
        ],
        [
          "It's finally Friday 🥳🥳",
          "You deserve the rest you are about to have $userName",
        ],
      ];
    }
    //For Saturday evening
    else if (day == 6) {
      // ignore: unused_local_vari.able
      List<List<String>> messages = [
        [
          "$userName, you earned the rest ohh",
          "Come on, let's start creating momentum for the week ahead",
        ],
        [
          "Hope you enjoyed today $userName",
          "You don't really need to plan today, just breathe and reflect",
        ],
        [
          "Good evening Boss 🫡🫡🫡",
          "Hope you rested well, Monday is knocking",
        ],
        [
          "It's mid weekend, hope you rested well",
          "Monday is around the corner, let's reflect and celebrate small wins",
        ],
        [
          "Hey $userName tonight is your quiet victory",
          "Reflect, rest and realign your energy",
        ],
      ];
    }
    //For Sunday evening
    else if (day == 7) {
      List<List<String>> messages = [
        [
          "The weekend is over 🥲😞"
              "Come on $userName, let's plan your Monday and own the week.",
        ],
        [
          "Just like that, it's already Monday😞😞",
          "Take a few minutes to plan your Monday",
        ],
        [
          "Hey $userName ready for Monday??",
          "Monday is tomorrow, let's plan to enter it well prepared",
        ],
        [
          "Hope you enjoyed your weekend $userName??",
          "Let's set the tone for the week, take a few mins to plan for Monday",
        ],
        [
          "Knock Knock !!!, it's Mondayyy",
          "Let's make a quick plan for tomorrow Boss",
        ],
      ];
    }
    //For Monday evening
    else if (day == 1) {
      List<List<String>> messages = [
        [
          "Hope today wasn't too stressful ??",
          "Let's make Tuesday better, plan it 🫡🫡",
        ],
        [
          "Today was a trailer $userName 😉😉",
          "Write tomorrow's script today, let's go",
        ],
        [
          "Monday doesn't control the week",
          "Let's take a moment to make the week even better ",
        ],
        [
          "Hope you enjoyed today $userName",
          "Onto the next, we go again tomorrow",
        ],
        [
          "The week just began, how is it going ??",
          "Take a breath, review today and let's make tomorrow better",
        ],
      ];
    }
    //For Tuesday evening
    else if (day == 2) {
      List<List<String>> messages = [
        [
          "Hey $userName, Tuesday is done already!! 🥳🥳",
          "Let's take a second to map out tomorrow",
        ],
        [
          "We are now in the week Boss 🫡🫡",
          "Let's set the pace for the rest of the week",
        ],
        [
          "You're doing great $userName",
          "Let's prepare tomorrow and finish the week strong",
        ],
        ["Keep pushing Boss 🥳🥳", "Plan now for a smoother Wednesday"],
        [
          "It was only Tuesday ??",
          "Let's make tomorrow even better, plan it out",
        ],
      ];
    }
    //For Wednesday evening
    else if (day == 3) {
      List<List<String>> messages = [
        ["It's mid-week $userName", "Let's make this week really count 🫡🫡"],
        [
          "Hey $userName, you made it halfway!! 🥳🥳",
          "Let's take a second to map out the second half",
        ],

        [
          "It's Thursday already $userName",
          "It's time to filter out what didn't work and double down on what did",
        ],
        [
          "Happy Hump Day Boss 🫡🫡",
          "Let's plan for a strong finish to the week",
        ],
        [
          "You're not tired, you are just getting started",
          "Let's prepare tomorrow and finish the week strong",
        ],
      ];
    }
    //For Thursday evening
    else if (day == 4) {
      List<List<String>> messages = [
        [
          "Almost there $userName 🫡🫡",
          "Plan now so we can celebrate the win on weekend",
        ],
        [
          "Finish line in sight Boss 🥳🥳",
          "Your best finish begins with a clear plan for Friday",
        ],
        ["It's Friday Eve!! 🥳🥳", "Let's make tomorrow count, plan it out"],
        [
          "Hey $userName, it's almost the weekend!! 🥳🥳",
          "One short plan tonight = a smooth finish tomorrow",
        ],
        [
          "The Friday's gift",
          "Map out tomorrow and thank yourself on Friday evening",
        ],
      ];
    } else{
      List<List<String>> messages = [
        [
          "Almost there $userName 🫡🫡",
          "Plan now so we can celebrate the win on weekend",
        ],
        
      ];
    }
    
    return messages[random.nextInt(messages.length)];
  }

  //Notification Function for the exact scheduled time
  Future<void> scheduleNotification(TaskClass task, DateTime taskTime) async {
    final now = DateTime.now();
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: now.millisecondsSinceEpoch.remainder(100000),
        channelKey: "task_channel",
        title: "Let's get to work $userName",
        body: "It's time to ${task.taskName}",
      ),
      actionButtons: [
        NotificationActionButton(
          key: "DONE",
          label: "Done",
          actionType: ActionType.Default,
        ),
        NotificationActionButton(
          key: "CANCEL",
          label: "Cancel",
          actionType: ActionType.DisabledAction,
        ),
      ],
      // schedule: NotificationCalendar(
      //   year: taskTime.year,
      //   month: taskTime.month,
      //   day: taskTime.day,
      //   hour: taskTime.hour,
      //   minute: taskTime.minute,
      //   second: 0,
      //   millisecond: 0,
      //   repeats: false,
      // ),
    );
    notifyListeners();
  }

  Future<void> scheduleConstantNotification() async {
    final notiMessage = specificMessage();
    final now = DateTime.now();
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: now.millisecondsSinceEpoch.remainder(100000),
        channelKey: "task_channel",
        title: notiMessage[0],
        body: notiMessage[1],
      ),

      // schedule: NotificationCalendar(
      //   hour: 20,
      //   minute: 0,
      //   second: 0,
      //   millisecond: 0,
      //   repeats: true,
      // ),
    );
    notifyListeners();
  }

  //Icon for the theme indicator
  Icon themeIcon = Icon(Icons.dark_mode, size: 16);
  //Current theme
  ThemeData _themeData = lightMode;
  //Getting the theme variable
  ThemeData get themeData => _themeData;
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  //Function to change theme

  ThemeMode get themeMode =>
      userInfo.get("appTheme") == "Dark" ? ThemeMode.dark : ThemeMode.light;
  String get appTheme => userInfo.get("appTheme");
  void themeOnpressed(String theme, BuildContext context) {
    userInfo.put("appTheme", theme);
    if (theme == "Dark") {
      themeData = darkMode;
      themeIcon = Icon(Icons.dark_mode, size: 16);
    } else if (theme == "Light") {
      themeData = lightMode;
      themeIcon = Icon(Icons.light_mode, size: 16);
    }
  }

  //Function to edit task
  void edit(String id, TaskClass inputNewTask, BuildContext context) {
    try {
      final initialTask = box.get(id);

      // Set the values in the input page to the values of the task to be changed
      inputTask.text = initialTask!.taskName;
      newCategory = initialTask.taskCategory;
      newTime = dtTotod(initialTask.taskTime);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TaskInput(
            action: "Update",
            title: "Edit your task",
            textController: inputTask,
            onAdd: () => onAdd(
              TaskClass(
                taskName: inputTask.text,
                taskState: false,
                taskCategory: newCategory,
                taskTime: todTodt(newTime),
                id: id,
                catColor: catColor,
              ),
              context,
              id,
              "rescheduled",
            ),
            categories: categories,
            newTask: initialTask,
          ),
        ),
      );
      notifyListeners();
    } catch (e) {
      debugPrint("Error editing task, close and try again later");
    }
  }
}
