import 'package:flutter/material.dart';

class NotificationButton extends StatelessWidget {
  Color colors;
  Function()? onPressed;
  String notiTime;
  Color borderColor;
 
  NotificationButton({
    super.key,
    required this.colors,
    required this.onPressed,
    required this.notiTime,
    required this.borderColor,
    
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 50,
      child: MaterialButton(
        padding: EdgeInsets.all(5),
        color: colors,
        
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: borderColor),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(child: Text(notiTime, style: TextStyle(fontSize: 13
        ),)
        
        ),
      ),
    );
  }
}
