// ignore_for_file: sized_box_for_whitespace

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:taskmate/classes/task_class.dart';
import 'package:taskmate/classes/task_provider.dart';
import 'package:taskmate/pages/history_page.dart';
import 'package:taskmate/pages/task_input.dart';
import 'package:taskmate/utilities/alert_dialog.dart';
import 'package:taskmate/utilities/button.dart';
import 'package:taskmate/utilities/task_tile.dart';
import 'package:taskmate/utilities/theme_dialog.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<TaskProvider>();
      if (provider.userName.isEmpty) {
        showAdaptiveDialog(
          context: context,
          builder: (context) {
            return CustomAlertDialog();
          },
        );
      } else {
        return;
      }

      Future<void> scheduleConstantNotification(
        TaskClass task,
        DateTime taskTime,
      ) async {
        print("Started");
        final now = DateTime.now();
        await AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: now.millisecondsSinceEpoch.remainder(100000),
            channelKey: "task_channel",

            title: context.watch<TaskProvider>().specificMessage()[0],
            body: context.watch<TaskProvider>().specificMessage()[1],
          ),

          schedule: NotificationCalendar(
            hour: 20,
            minute: 0,
            second: 0,
            millisecond: 0,
            repeats: true,
          ),
        );
        print("Stopped");
      }
    });
    // The dialog to get the user's name
    // showAdaptiveDialog(
    //   context: context,
    //   builder: (context) {
    //     return CustomAlertDialog();
    //   },
    // );

    //The trigger for the constant night reminder notification

    // Displaying the Notification permission
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    // AwesomeNotifications().setListeners(
    //   onActionReceivedMethod: (ReceivedAction action) async {
    //     if (action.buttonKeyPressed == "DONE") {
    //       final box = context.read<TaskProvider>().box;
    //       final task = box.get(action.id.toString());
    //       if (task != null) {
    //         setState(() {
    //           task.taskState = true;
    //           task.save();
    //         });
    //       }
    //     } else if (action.buttonKeyPressed == "CANCEL") {
    //       final box = context.read<TaskProvider>().box;
    //       final task = box.get(action.id.toString());
    //       if (task != null) {
    //         context.read<TaskProvider>().scheduleNotification(
    //           task,
    //           DateTime.now(),
    //         );
    //       }
    //     }
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    //Keys for the taskModels inside the Hive box
    final keys = context
        .watch<TaskProvider>()
        .box
        .keys
        .toList()
        .reversed
        .toList();
    //Random id generator for new tasks
    var uid = context.watch<TaskProvider>().uuid.v4.toString();
    // New list for the categorization feature in reverse way to show newly added tasks on top
    final filtered = context
        .watch<TaskProvider>()
        .filteredTask
        .reversed
        .toList();
    double screenWidth = MediaQuery.of(context).size.width;
    return Consumer<TaskProvider>(
      builder: (context, providerModel, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        endDrawer: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(12),
            ),

            height: 500,
            width: 250,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).textTheme.bodyLarge!.color!.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    height: 40,
                    width: 250,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.home, size: 16),
                          SizedBox(width: 8),
                          Text("Home"),
                        ],
                      ),
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HistoryPage()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).textTheme.bodyLarge!.color!.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      height: 40,
                      width: 250,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(Icons.history, size: 16),
                            SizedBox(width: 8),
                            Text("Task History"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    showAdaptiveDialog(
                      context: context,
                      builder: (context) {
                        return ThemeDialog();
                      },
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).textTheme.bodyLarge!.color!.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      height: 40,
                      width: 250,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            providerModel.themeIcon,
                            SizedBox(width: 8),
                            Text("Theme"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showAdaptiveDialog(
                      context: context,
                      builder: (context) {
                        return CustomAlertDialog();
                      },
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).textTheme.bodyLarge!.color!.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      height: 40,
                      width: 250,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(Icons.history, size: 16),
                            SizedBox(width: 8),
                            Text("Edit Name"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showAdaptiveDialog(
                      context: context,
                      builder: (context) {
                        return CustomAlertDialog();
                      },
                    );
                  }, 
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).textTheme.bodyLarge!.color!.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      height: 40,
                      width: 250,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(Icons.notifications, size: 16),
                            SizedBox(width: 8),
                            Text("Notification"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide.none,
          ),
          backgroundColor: providerModel.appColor,
          onPressed: () {
            //providerModel.historyBox.deleteFromDisk();
            Navigator.push(
              context,
              MaterialPageRoute(
                //Navigating to the task entry page
                builder: (context) => TaskInput(
                  action: "Add",
                  title: "Add a New Task",
                  // The new task passed as an argument to the input page
                  newTask: TaskClass(
                    taskName: providerModel.inputTask.text,
                    taskState: false,
                    taskCategory: providerModel.newCategory,
                    taskTime: providerModel.todTodt(providerModel.newTime),
                    id: uid,
                    catColor: providerModel.catColor,
                  ),
                  textController: providerModel.inputTask,
                  //The add function passed as an argument to the input page
                  onAdd: () => setState(() {
                    providerModel.onAdd(
                      TaskClass(
                        taskName: providerModel.inputTask.text,
                        taskState: false,
                        taskCategory: providerModel.newCategory,
                        taskTime: providerModel.todTodt(providerModel.newTime),
                        id: uid,
                        catColor: providerModel.catColor,
                      ),
                      context,
                      DateTime.now().millisecondsSinceEpoch.toString(),
                      "scheduled",
                    );
                  }),
                  categories: providerModel.categories,
                ),
              ),
            );
          },
          child: Icon(
            Icons.add,
            size: 30,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
        appBar: AppBar(
          title: Row(
            children: [
              Text(
                "Welcome ${providerModel.userInfo.get("userName").toString()} ",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Theme.of(context).textTheme.bodyLarge!.color!,
                  fontFamily: 'Inter',
                  fontSize: 18,
                ),
              ),
              Spacer(),
              Container(
                height: 22,
                width: 22,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: providerModel.appColor,
                ),
                child: Center(
                  child: Text(
                    filtered.length.toString(),
                    style: TextStyle(
                      color: Theme.of(
                        context,
                      ).scaffoldBackgroundColor.withOpacity(0.9),
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: Theme.of(context).colorScheme.surface,
        ),
        body: ValueListenableBuilder(
          valueListenable: providerModel.box.listenable(),
          builder: (BuildContext context, value, child) => Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      //Category buttons shown horizontally with different colors signifying different task category
                      children: [
                        Button(
                          onPressed: () {
                            setState(() {
                              providerModel.cat = "All";
                            });
                          },
                          colors: providerModel.cat == "All"
                              ? Colors.white
                              : Theme.of(context).scaffoldBackgroundColor,

                          text: "All",

                          borderColor: Colors.black,
                          textColor: providerModel.cat == "All"
                              ? Colors.black
                              : Theme.of(context).textTheme.bodyLarge!.color!,
                        ),
                        SizedBox(width: 8),
                        Button(
                          onPressed: () {
                            setState(() {
                              providerModel.cat = "Work";
                            });
                          },
                          colors: providerModel.cat == "Work"
                              ? Colors.red
                              : Theme.of(context).scaffoldBackgroundColor,

                          text: "Work",
                          borderColor: Colors.red,
                          textColor: Theme.of(
                            context,
                          ).textTheme.bodyLarge!.color!,
                        ),
                        SizedBox(width: 8),
                        Button(
                          onPressed: () {
                            setState(() {
                              providerModel.cat = "Personal";
                            });
                          },
                          colors: providerModel.cat == "Personal"
                              ? Colors.purple
                              : Theme.of(context).scaffoldBackgroundColor,

                          text: "Personal",
                          borderColor: Colors.purple,
                          textColor: Theme.of(
                            context,
                          ).textTheme.bodyLarge!.color!,
                        ),
                        SizedBox(width: 8),
                        Button(
                          onPressed: () {
                            setState(() {
                              providerModel.cat = "Education";
                            });
                          },
                          colors: providerModel.cat == "Education"
                              ? Colors.blue
                              : Theme.of(context).scaffoldBackgroundColor,

                          text: "Education",
                          borderColor: Colors.blue,
                          textColor: Theme.of(
                            context,
                          ).textTheme.bodyLarge!.color!,
                        ),
                        SizedBox(width: 8),
                        Button(
                          onPressed: () {
                            setState(() {
                              providerModel.cat = "Projects";
                            });
                          },
                          colors: providerModel.cat == "Projects"
                              ? Colors.orange
                              : Theme.of(context).scaffoldBackgroundColor,

                          text: "Projects",
                          borderColor: Colors.orange,
                          textColor: Theme.of(
                            context,
                          ).textTheme.bodyLarge!.color!,
                        ),
                        SizedBox(width: 8),
                        Button(
                          onPressed: () {
                            setState(() {
                              providerModel.cat = "Others";
                            });
                          },
                          colors: providerModel.cat == "Others"
                              ? Colors.green
                              : Theme.of(context).scaffoldBackgroundColor,

                          text: "Others",
                          borderColor: Colors.green,
                          textColor: Theme.of(
                            context,
                          ).textTheme.bodyLarge!.color!,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height - 170,
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisExtent: 80,
                                mainAxisSpacing: 8,
                                crossAxisSpacing: 8,
                                crossAxisCount: screenWidth <= 400 ? 1 : 2,
                              ),
                          itemCount: filtered.length,
                          itemBuilder: (BuildContext context, int index) {
                            //Each new model from the filtered list based on the categorization
                            final tasks = filtered[index];
                            //The normal list from the box
                            final key = keys[index];

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: TaskTile(
                                editFunction: () => setState(() {
                                  providerModel.edit(
                                    key,
                                    providerModel.box.get(key)!,
                                    context,
                                  );
                                }),
                                checkFunction: (bool? value) {
                                  setState(() {
                                    providerModel.onCheckFunction(
                                      key,
                                      providerModel.box.get(key),
                                    );
                                    providerModel.onHistoryCheckFunction(
                                      key,
                                      providerModel.historyBox.get(key),
                                    );
                                  });
                                },
                                checkValue: providerModel.box
                                    .get(key)!
                                    .taskState,
                                taskName: tasks.taskName,
                                deleteFunction: () {
                                  setState(() {
                                    providerModel.onDelete(key);
                                  });
                                },
                                time: tasks.taskTime,
                                category: tasks.taskCategory,
                                catColor: tasks.catColor,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
