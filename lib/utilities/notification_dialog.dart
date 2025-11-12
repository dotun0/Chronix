import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmate/classes/task_provider.dart';

import 'package:taskmate/utilities/theme_button.dart';

class NotificationDialog extends StatefulWidget {
  const NotificationDialog({super.key});

  @override
  State<NotificationDialog> createState() => _NotificationDialogState();
}

class _NotificationDialogState extends State<NotificationDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.7),
      title: Text(
      textAlign: TextAlign.center,
        "What time would you like your notification?",
        style: TextStyle(fontSize: 15,),
      ),
      content: SizedBox(
        height: 120,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                ThemeButton(
                  colors:
                      context.watch<TaskProvider>().userInfo.get("appTheme") ==
                          "Light"
                      ? Colors.white
                      : Colors.transparent,
                      
                  onPressed: () {
                    context.read<TaskProvider>().themeOnpressed(
                      "Light",
                      context,
                    );
                  },
                  themeIcon: Icon(Icons.light_mode, color: Theme.of(context).textTheme.bodyLarge!.color!),
                  borderColor: Colors.white,
                  
                ),
                SizedBox(height: 8),
                Text("Light", style: TextStyle(
                  color: context.watch<TaskProvider>().userInfo.get("appTheme") ==
                          "Light"
                      ? Colors.white
                      : Colors.white.withOpacity(0.5)
                ),),
              ],
            ),
            SizedBox(width: 8),
            Column(
              children: [
                ThemeButton(
                  colors:
                      context.watch<TaskProvider>().userInfo.get("appTheme") ==
                          "Dark"
                      ? Colors.black
                      : Theme.of(context).scaffoldBackgroundColor.withOpacity(0.5),
                  onPressed: () {
                    context.read<TaskProvider>().themeOnpressed(
                      "Dark",
                      context,
                    );
                  },
                  themeIcon: Icon(Icons.dark_mode, color: Theme.of(context).textTheme.bodyLarge!.color!,),
                  borderColor: Colors.black,
                  
                ),
                SizedBox(height: 8),
                Text("Dark", style: TextStyle(
                  color: context.watch<TaskProvider>().userInfo.get("appTheme") ==
                          "Dark"
                      ? Colors.black
                      : Colors.black.withOpacity(0.5)
                ),),
              ],
            ),
          ],
        ),
      ),
      actions: [
        
      ],
    );
  }
}
