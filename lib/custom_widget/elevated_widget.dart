import 'package:flutter/material.dart';

class ElevatedWidget extends StatelessWidget {
  const ElevatedWidget({
    super.key,
    required this.title,
    this.onPressed, this.color, this.backgroundColor,
  });

  final String title;
  final VoidCallback? onPressed;
  final Color? color;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(backgroundColor: backgroundColor),
      child: Text(
        title,
        style: TextStyle(color: color),
      ),
    );
  }
}
