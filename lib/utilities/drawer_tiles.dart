import 'package:flutter/material.dart';

class DrawerTiles extends StatelessWidget {
  VoidCallback action;
  IconData icon;
  String label;
  DrawerTiles({
    super.key,
    required this.action,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, left: 8, right: 8),
      child: MaterialButton(
        onPressed: action,
        height: 40,
        minWidth: 250,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.3),
        child: Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8, right: 8),
          child: Row(
            children: [Icon(icon, size: 16), SizedBox(width: 8), Text(label)],
          ),
        ),
      ),
    );
  }
}
