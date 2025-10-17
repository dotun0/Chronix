import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmate/classes/task_provider.dart';

class HistoryTaskTile extends StatelessWidget {
  String taskName;

  DateTime time;
  String category;
  int catColor;
  String date;
  Color tileColor;
  Color textColor;
  
  HistoryTaskTile({
    super.key,

    required this.taskName,

    required this.time,
    required this.category,
    required this.catColor,
    required this.date,
    required this.tileColor,
    required this.textColor
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: tileColor,
      ),
      height: 80,
      width: double.infinity,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 32),
                  child: Tooltip(
                    message: taskName,
                    showDuration: Duration(seconds: 2),
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      taskName,
                      maxLines: 1,
                      style: TextStyle(color: textColor, fontSize: 19),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  date,

                  style: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,

                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              //margin: EdgeInsets.only(left: 313, bottom: 35),
              height: 20,
              width: 70,
              decoration: BoxDecoration(
                color: Color(catColor),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Center(
               
                child: Text(category, style: TextStyle(fontSize: 12),),
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
                  fontSize: 13,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
