// ignore_for_file: deprecated_member_us

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:taskmate/classes/task_class.dart';
import 'package:taskmate/classes/theme_class.dart';
import 'package:taskmate/pages/home.dart';
import 'package:taskmate/pages/task_input.dart';
import 'package:uuid/uuid.dart';

class TaskProvider extends ChangeNotifier {
  TextEditingController userInputName = TextEditingController();
  String userName = "";
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
      userName = userInputName.text;
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
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
              "${inputTask.text} was ${message} for ${newTime.format(context)}",
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

  //Notification Function for the exact scheduled time
  Future<void> scheduleNotification(TaskClass task, DateTime taskTime) async {
    final now = DateTime.now();
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: now.millisecondsSinceEpoch.remainder(100000),
        channelKey: "task_channel",
        title: "It's time to ${task.taskName}",
        body: "Let's get to work",
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
      schedule: NotificationCalendar(
        year: now.year,
        month: now.month,
        day: now.day,
        hour: taskTime.hour,
        minute: taskTime.minute,
        second: 0,
        millisecond: 0,
        repeats: false,
      ),
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
  void changeTheme() {
    if (themeData == lightMode) {
      themeData = darkMode;
      themeIcon = Icon(Icons.light_mode, size: 16);
    } else {
      themeData = lightMode;
      themeIcon = Icon(Icons.dark_mode, size: 16);
    }
    notifyListeners();
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
