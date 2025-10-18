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
