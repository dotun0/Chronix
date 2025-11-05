import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmate/classes/task_provider.dart';
import 'package:taskmate/utilities/button.dart';

class CustomAlertDialog extends StatefulWidget {
  const CustomAlertDialog({super.key});

  @override
  State<CustomAlertDialog> createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "What would you like to be called??",
        style: TextStyle(fontSize: 16),
      ),
      content: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        controller: context.read<TaskProvider>().userInputName,
      ),
      actions: [
        Button(
          colors: context.read<TaskProvider>().appColor,
          onPressed: () {
            setState(() {
              context.read<TaskProvider>().updateName(
                context.read<TaskProvider>().userInputName,
                context,
              );
            });
          },
          text: "Submit",
          borderColor: Theme.of(context).textTheme.bodyLarge!.color!,
          textColor: Theme.of(context).textTheme.bodyLarge!.color!,
        ),
      ],
    );
  }
}
