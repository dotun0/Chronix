import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  Color colors;
  Function()? onPressed;
  String text;
  Color borderColor;
  Color textColor;
  Button({
    super.key,
    required this.colors,
    required this.onPressed,
    required this.text,
    required this.borderColor,
    required this.textColor
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: colors,
      height: 40,
      minWidth: 100,
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 1, color: borderColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(text, style: TextStyle(
        color: textColor
      ),),
    );
  }
}

// Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//               controller: widget.textController,
//             ),
//             SizedBox(height: 8),
//             Row(
//               children: [
//                 Column(
//                   children: [
//                     Text("Category"),
//                     SizedBox(height: 8),
//                     Container(
//                       height: 20,
//                       width: 30,
//                       child: DropdownButton(
//                         items: widget.categories.map<DropdownMenuItem>((item) {
//                           return DropdownMenuItem(child: Text(item));
//                         }).toList(),
//                         onChanged: (value) {
//                           context.read<TaskProvider>().setCategory(value);
//                         },
//                         icon: Icon(Icons.arrow_drop_down),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(width: 8),
//                 MaterialButton(
//                   shape: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                     borderSide: BorderSide(width: 1),
//                   ),
//                   height: 40,
//                   minWidth: 50,
//                   color: Colors.white,
//                   onPressed: () {
//                     setState(() {
//                       showTimePicker(
//                         context: context,
//                         initialTime: TimeOfDay.now(),
//                       ).then((time) {
//                         context.read<TaskProvider>().setTime(time!);
//                       });
//                     });
//                   },
//                   child: Text(
//                     context.watch<TaskProvider>().newTime.format(context),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 30),

//             ElevatedButton(onPressed: widget.onAdd, child: Text("Add")),
//           ],
//         ),
