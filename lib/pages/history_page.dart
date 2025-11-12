// ignore_for_file: sized_box_for_whitespace

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:taskmate/classes/task_class.dart';
import 'package:taskmate/classes/task_provider.dart';
import 'package:taskmate/pages/home.dart';
import 'package:taskmate/pages/task_input.dart';
import 'package:taskmate/utilities/button.dart';
import 'package:taskmate/utilities/history_task_tile.dart';
import 'package:taskmate/utilities/task_tile.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    //Keys for the taskModels inside the Hive box
    final keys = context
        .watch<TaskProvider>()
        .historyBox
        .keys
        .toList()
        .reversed
        .toList();
    //Random id generator for new tasks
    //var uid = context.watch<TaskProvider>().uuid.v4.toString();
    // New list for the categorization feature in reverse way to show newly added tasks on top
    final doneHistory = context
        .watch<TaskProvider>()
        .doneHistoryTask
        .reversed
        .toList();
    final undoneHistory = context
        .watch<TaskProvider>()
        .undoneHistoryTask
        .reversed
        .toList();
    double screenWidth = MediaQuery.of(context).size.width;
    return Consumer<TaskProvider>(
      builder: (context, providerModel, child) => DefaultTabController(
        length: 2,
        child: Scaffold(
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
                GestureDetector(
                  onTap: () {
                    setState(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Home()),
                      );
                    });
                    Navigator.pop(context);
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
                            Icon(Icons.home, size: 16),
                            SizedBox(width: 8),
                            Text("Home Page"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),


                GestureDetector(
                  onTap: () {
                    setState(() {
                      providerModel.historyBox.clear();
                    });
                    Navigator.pop(context);
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
                            Icon(Icons.delete_forever, size: 16),
                            SizedBox(width: 8),
                            Text("Clear History"),
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
        
          // endDrawer: Container(
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(12),
          //     color: const Color.fromRGBO(33, 150, 243, 1).withOpacity(0.7),
          //   ),

          //   height: 300,
          //   width: 200,
          //   child: Column(
          //     children: [
          //       MaterialButton(
          //         onPressed: () {
          //           setState(() {
          //             providerModel.historyBox.clear();
          //           });
          //           Navigator.pop(context);
          //         },
          //         minWidth: 180,
          //         shape: OutlineInputBorder(
          //           borderSide: BorderSide.none,
          //           borderRadius: BorderRadius.circular(12),
          //         ),
          //         color: Theme.of(
          //           context,
          //         ).scaffoldBackgroundColor.withOpacity(0.5),
          //         child: Text("Clear History"),
          //       ),

          //       Divider(),
          //       MaterialButton(
          //         onPressed: () {
          //           setState(() {
          //             Navigator.push(
          //               context,
          //               MaterialPageRoute(builder: (context) => Home()),
          //             );
          //           });
          //           Navigator.pop(context);
          //         },
          //         minWidth: 180,
          //         shape: OutlineInputBorder(
          //           borderSide: BorderSide.none,
          //           borderRadius: BorderRadius.circular(12),
          //         ),
          //         color: Theme.of(
          //           context,
          //         ).scaffoldBackgroundColor.withOpacity(0.5),
          //         child: Text("Home Page"),
          //       ),
          //       Divider(),
          //       Container(
          //         height: 50,
          //         width: 250,
          //         child: Row(
          //           children: [Icon(Icons.history), Text("Task History")],
          //         ),
          //       ),
          //       Divider(),
          //     ],
          //   ),
          // ),

          appBar: AppBar(
            title: Row(children: [Text("Task History")]),
            bottom: TabBar(
              dividerHeight: 0,
              tabs: [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Undone", style: TextStyle(fontSize: 17)),
                      SizedBox(width: 8),
                      Container(
                        height: 21,
                        width: 21,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Theme.of(
                            context,
                          ).textTheme.bodyLarge!.color!.withOpacity(0.7),
                        ),
                        child: Center(
                          child: Text(
                            undoneHistory.length.toString(),
                            style: TextStyle(
                              color: Theme.of(
                                context,
                              ).scaffoldBackgroundColor.withOpacity(0.9),
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Done", style: TextStyle(fontSize: 17)),
                      SizedBox(width: 8),
                      Container(
                        height: 21,
                        width: 21,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Theme.of(
                            context,
                          ).textTheme.bodyLarge!.color!.withOpacity(0.7),
                        ),
                        child: Center(
                          child: Text(
                            doneHistory.length.toString(),
                            style: TextStyle(
                              color: Theme.of(
                                context,
                              ).scaffoldBackgroundColor.withOpacity(0.9),
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: TabBarView(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height - 170,
                        child: ValueListenableBuilder(
                          valueListenable: providerModel.historyBox
                              .listenable(),
                          builder: (BuildContext context, value, child) =>
                              GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisExtent: 85,
                                      crossAxisCount: screenWidth <= 400
                                          ? 1
                                          : 2,
                                      mainAxisSpacing: 8,
                                      crossAxisSpacing: 16,
                                    ),
                                itemCount: undoneHistory.length,
                                itemBuilder: (BuildContext context, int index) {
                                  //providerModel.historyState = false;
                                  //Each new model from the filtered list based on the categorization
                                  final tasks = undoneHistory[index];
                                  //The normal list from the box
                                  final key = keys[index];
                                  DateTime taskDate = tasks.taskTime;
                                  String formattedDate = DateFormat(
                                    "d MMM yyyy",
                                  ).format(taskDate);
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: HistoryTaskTile(
                                      taskName: tasks.taskName,
                                      time: tasks.taskTime,
                                      category: tasks.taskCategory,
                                      catColor: tasks.catColor,
                                      date: "Scheduled on $formattedDate",
                                      tileColor: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                      textColor: Theme.of(
                                        context,
                                      ).textTheme.bodyLarge!.color!,
                                    ),
                                  );
                                },
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height - 170,
                        child: ValueListenableBuilder(
                          valueListenable: providerModel.historyBox
                              .listenable(),
                          builder: (BuildContext context, value, child) =>
                              GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisSpacing: 16,
                                      mainAxisSpacing: 8,
                                      mainAxisExtent: 85,
                                      crossAxisCount: screenWidth <= 400
                                          ? 1
                                          : 2,
                                    ),
                                itemCount: doneHistory.length,
                                itemBuilder: (BuildContext context, int index) {
                                  // providerModel.historyState = true;
                                  //Each new model from the filtered list based on the categorization
                                  final tasks = doneHistory[index];
                                  //The normal list from the box
                                  final key = keys[index];
                                  DateTime taskDate = tasks.taskTime;
                                  String formattedDate = DateFormat(
                                    "d MMM yyyy",
                                  ).format(taskDate);
                                  String formattedTime = providerModel
                                      .dtTotod(tasks.taskTime)
                                      .format(context);
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: HistoryTaskTile(
                                      taskName: tasks.taskName,
                                      time: tasks.taskTime,
                                      category: tasks.taskCategory,
                                      catColor: tasks.catColor,
                                      date: "Scheduled on $formattedDate",
                                      tileColor: Theme.of(
                                        context,
                                      ).colorScheme.primary.withOpacity(0.3),
                                      textColor: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .color!
                                          .withOpacity(0.5),
                                    ),
                                  );
                                },
                              ),
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
