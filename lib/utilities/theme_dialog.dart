import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmate/classes/task_provider.dart';

import 'package:taskmate/utilities/theme_button.dart';

class ThemeDialog extends StatefulWidget {
  const ThemeDialog({super.key});

  @override
  State<ThemeDialog> createState() => _ThemeDialogState();
}

class _ThemeDialogState extends State<ThemeDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.all(12),
      contentPadding: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.7),
      title: Text(
      textAlign: TextAlign.center,
        "What theme would you like to use??",
        style: TextStyle(fontSize: 15,),
      ),
      content: SizedBox(
        height: 90,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
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
            SizedBox(width: 32),
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
