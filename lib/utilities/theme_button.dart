import 'package:flutter/material.dart';

class ThemeButton extends StatelessWidget {
  Color colors;
  Function()? onPressed;
  Icon themeIcon;
  Color borderColor;
 
  ThemeButton({
    super.key,
    required this.colors,
    required this.onPressed,
    required this.themeIcon,
    required this.borderColor,
    
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 60,
      child: MaterialButton(
        color: colors,
        
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: borderColor),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(child: themeIcon
        
        ),
      ),
    );
  }
}
