import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmate/classes/task_provider.dart';
import 'package:taskmate/utilities/notification_button.dart';

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
      contentPadding: EdgeInsets.all(8),
      actionsPadding: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Theme.of(
        context,
      ).scaffoldBackgroundColor.withOpacity(0.7),
      title: Text(
        textAlign: TextAlign.center,
        "What time would you like your notification?",
        style: TextStyle(fontSize: 15),
      ),
      content: SizedBox(
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            NotificationButton(
              colors: context.read<TaskProvider>().constantTime == 19
                  ? context.read<TaskProvider>().appColor.withOpacity(0.5)
                  : Theme.of(context).scaffoldBackgroundColor,
              onPressed: () {
                setState(() {
                  context.read<TaskProvider>().setConstantTime(19, context);
                  AwesomeNotifications().cancel(
                    context.read<TaskProvider>().notificationID,
                  );
                  context
                      .read<TaskProvider>()
                      .scheduleConstantNotification();
                  Navigator.pop(context);
                });
        
                print(context.read<TaskProvider>().constantTime);
              },
              notiTime: "7PM",
              borderColor: Theme.of(context).textTheme.bodyLarge!.color!,
            ),
        
            SizedBox(height: 8),
            NotificationButton(
              colors: context.read<TaskProvider>().constantTime == 20
                  ? context.read<TaskProvider>().appColor.withOpacity(0.5)
                  : Theme.of(context).scaffoldBackgroundColor,
              onPressed: () {
                setState(() {
                  context.read<TaskProvider>().setConstantTime(20, context);
                  AwesomeNotifications().cancel(
                    context.read<TaskProvider>().notificationID,
                  );
                  context
                      .read<TaskProvider>()
                      .scheduleConstantNotification();
                  Navigator.pop(context);
                });
                print(context.read<TaskProvider>().constantTime);
              },
              notiTime: "8PM",
              borderColor: Theme.of(context).textTheme.bodyLarge!.color!,
            ),
        
            SizedBox(height: 8),
            NotificationButton(
              colors: context.read<TaskProvider>().constantTime == 21
                  ? context.read<TaskProvider>().appColor.withOpacity(0.5)
                  : Theme.of(context).scaffoldBackgroundColor,
              onPressed: () {
                setState(() {
                  context.read<TaskProvider>().setConstantTime(21, context);
                  AwesomeNotifications().cancel(
                    context.read<TaskProvider>().notificationID,
                  );
                  context
                      .read<TaskProvider>()
                      .scheduleConstantNotification();
                  Navigator.pop(context);
                });
        
                print(context.read<TaskProvider>().constantTime);
              },
              notiTime: "9PM",
              borderColor: Theme.of(context).textTheme.bodyLarge!.color!,
            ),
            SizedBox(height: 8),
            NotificationButton(
              colors: context.read<TaskProvider>().constantTime == 22
                  ? context.read<TaskProvider>().appColor.withOpacity(0.5)
                  : Theme.of(context).scaffoldBackgroundColor,
              onPressed: () {
                setState(() {
                  context.read<TaskProvider>().setConstantTime(22, context);
                  AwesomeNotifications().cancel(
                    context.read<TaskProvider>().notificationID,
                  );
                  context
                      .read<TaskProvider>()
                      .scheduleConstantNotification();
                  Navigator.pop(context);
                });
        
                print(context.read<TaskProvider>().constantTime);
              },
              notiTime: "10PM",
              borderColor: Theme.of(context).textTheme.bodyLarge!.color!,
            ),
          ],
        ),
      ),
      actions: [],
    );
  }
}
