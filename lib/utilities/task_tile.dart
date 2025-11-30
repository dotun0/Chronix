import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmate/classes/task_provider.dart';

class TaskTile extends StatelessWidget {
  bool checkValue;
  Function(bool?) checkFunction;
  String taskName;
  VoidCallback deleteFunction;
  DateTime time;
  String category;
  int catColor;
  VoidCallback editFunction;
  TaskTile({
    super.key,
    required this.checkFunction,
    required this.checkValue,
    required this.taskName,
    required this.deleteFunction,
    required this.time,
    required this.category,
    required this.catColor,
    required this.editFunction,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: editFunction,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).colorScheme.primary,
        ),
        height: 70,
        width: double.infinity,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10, right: 8),
              child: Row(
                children: [
                  Checkbox(
                    value: checkValue,
                    onChanged: checkFunction,
                    checkColor: Theme.of(context).colorScheme.surface,
                    activeColor: Theme.of(
                      context,
                    ).textTheme.bodyLarge!.color!.withOpacity(0.5),
                    side: BorderSide(
                      color: Theme.of(
                        context,
                      ).colorScheme.tertiary.withOpacity(0.5),
                      width: 2,
                    ),
                  ),
                  
                  SizedBox(
                    width: 150,
                    child: Tooltip(
                      message: taskName,
                      child: Text(
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        taskName,
                        maxLines: 1,
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                      
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: deleteFunction,
                    child: Icon(
                      Icons.delete,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                //margin: EdgeInsets.only(left: 313, bottom: 35),
                height: 15,
                width: 15,
                decoration: BoxDecoration(
                  color: Color(catColor),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8, right: 8),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  context.watch<TaskProvider>().dtTotod(time).format(context),

                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
