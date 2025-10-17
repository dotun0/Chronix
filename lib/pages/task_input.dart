// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmate/classes/task_class.dart';
import 'package:taskmate/classes/task_provider.dart';

class TaskInput extends StatefulWidget {
  TextEditingController textController;
  VoidCallback onAdd;
  List categories;
  TaskClass newTask;
  String title;
  String action;

  TaskInput({
    super.key,
    required this.textController,
    required this.onAdd,
    required this.categories,
    required this.newTask,
    required this.title,
    required this.action,
  });

  @override
  State<TaskInput> createState() => _TaskInputState();
}

class _TaskInputState extends State<TaskInput> {
  @override
  Widget build(BuildContext context) {
    Color appColor = const Color(0xFF2048ff);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: screenWidth >= 400
          ? SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(right: 80, left: 80, top: 32),
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(widget.title, style: TextStyle(fontSize: 24)),
                    SizedBox(height: 24),
                    TextField(
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: appColor),
                        ),

                        hint: Text(
                          "Input your task",

                          style: TextStyle(
                            color: Theme.of(
                              context,
                            ).textTheme.bodyLarge!.color!.withOpacity(0.7),
                            fontSize: 17,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      controller: widget.textController,
                    ),

                    SizedBox(height: 12),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Category"),
                            SizedBox(height: 8),
                            Container(
                              height: 50,
                              width: 200,
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(width: 1, color: appColor),
                                  bottom: BorderSide(
                                    width: 1,
                                    color: appColor,
                                  ),
                                  right: BorderSide(
                                    width: 1,
                                    color: appColor,
                                  ),
                                  left: BorderSide(
                                    width: 1,
                                    color: appColor,
                                  ),
                                ),
                                borderRadius: BorderRadius.circular(12),

                                color: Theme.of(
                                  context,
                                ).scaffoldBackgroundColor,
                              ),
                              child: DropdownButton(
                                borderRadius: BorderRadius.circular(8),
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(
                                    context,
                                  ).textTheme.bodyLarge!.color,
                                ),
                                padding: EdgeInsets.all(12),
                                underline: Container(height: 0),
                                value: context
                                    .watch<TaskProvider>()
                                    .newCategory,
                                //icon: Icon(Icons.arrow_drop_down),
                                items: widget.categories
                                    .map<DropdownMenuItem<String>>((item) {
                                      return DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item + "                         ",
                                        ),
                                      );
                                    })
                                    .toList(),

                                onChanged: (value) => setState(() {
                                  if (value != null) {
                                    setState(() {
                                      context.read<TaskProvider>().setCategory(
                                        value,
                                      );
                                      //print(value);
                                    });
                                  }
                                }),
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Time"),
                            SizedBox(height: 8),
                            MaterialButton(
                              shape: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: appColor,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              color: Theme.of(context).scaffoldBackgroundColor,
                              height: 50,
                              minWidth: 200,
                              onPressed: () {
                                setState(() {
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  ).then((time) {
                                    context.read<TaskProvider>().setTime(
                                      time!,
                                      widget.newTask,
                                    );
                                  });
                                });
                              },
                              child: Text(
                                context.watch<TaskProvider>().newTime.format(
                                  context,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        MaterialButton(
                          shape: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          color: appColor,
                          height: 50,
                          minWidth: 200,
                          onPressed: widget.onAdd,
                          child: Text(
                            widget.action,
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        Spacer(),
                        MaterialButton(
                          shape: OutlineInputBorder(
                            borderSide: BorderSide(color: appColor),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          color: Theme.of(context).scaffoldBackgroundColor,
                          height: 50,
                          minWidth: 200,
                          onPressed: () {
                            setState(() {
                              Navigator.pop(context);
                            });
                          },
                          child: Text("Cancel", style: TextStyle(fontSize: 17)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(widget.title, style: TextStyle(fontSize: 24)),
                  SizedBox(height: 24),
                  TextField(
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: appColor),
                      ),

                      hint: Text(
                        "Input your task",
                        style: TextStyle(
                          color: Theme.of(
                            context,
                          ).textTheme.bodyLarge!.color!.withOpacity(0.7),
                          fontSize: 17,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    controller: widget.textController,
                  ),

                  SizedBox(height: 12),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Category"),
                          SizedBox(height: 8),
                          Container(
                            height: 50,
                            width: 200,
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(width: 1, color: appColor),
                                bottom: BorderSide(
                                  width: 1,
                                  color: appColor,
                                ),
                                right: BorderSide(width: 1, color: appColor),
                                left: BorderSide(width: 1, color: appColor),
                              ),
                              borderRadius: BorderRadius.circular(12),

                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            child: DropdownButton(
                              borderRadius: BorderRadius.circular(8),
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Theme.of(
                                  context,
                                ).textTheme.bodyLarge!.color,
                              ),
                              padding: EdgeInsets.all(12),
                              underline: Container(height: 0),
                              value: context.watch<TaskProvider>().newCategory,
                              icon: Icon(Icons.arrow_drop_down),
                              items: widget.categories
                                  .map<DropdownMenuItem<String>>((item) {
                                    return DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item + "                         ",
                                      ),
                                    );
                                  })
                                  .toList(),

                              onChanged: (value) => setState(() {
                                if (value != null) {
                                  setState(() {
                                    context.read<TaskProvider>().setCategory(
                                      value,
                                    );
                                    //print(value);
                                  });
                                }
                              }),
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Time"),
                          SizedBox(height: 8),
                          MaterialButton(
                            shape: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: appColor,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            color: Theme.of(context).scaffoldBackgroundColor,
                            height: 50,
                            minWidth: 120,
                            onPressed: () {
                              setState(() {
                                showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                ).then((time) {
                                  context.read<TaskProvider>().setTime(
                                    time!,
                                    widget.newTask,
                                  );
                                });
                              });
                            },
                            child: Text(
                              context.watch<TaskProvider>().newTime.format(
                                context,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      MaterialButton(
                        shape: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        color: appColor,
                        height: 50,
                        minWidth: 160,
                        onPressed: widget.onAdd,
                        child: Text(
                          widget.action,
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                      Spacer(),
                      MaterialButton(
                        shape: OutlineInputBorder(
                          borderSide: BorderSide(color: appColor),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        color: Theme.of(context).scaffoldBackgroundColor,
                        height: 50,
                        minWidth: 160,
                        onPressed: () {
                          setState(() {
                            Navigator.pop(context);
                          });
                        },
                        child: Text("Cancel", style: TextStyle(fontSize: 17)),
                      ),
                      Spacer(),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
