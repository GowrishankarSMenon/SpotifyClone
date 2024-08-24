import 'package:flutter/material.dart';

class BasicAppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final double? height;
  final Color? textColor; // Add this line

  const BasicAppButton({
    required this.onPressed,
    required this.title,
    this.height,
    this.textColor, // Add this line
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(height ?? 80),
      ),
      child: Text(
        title,
        style: TextStyle(color: textColor ?? Colors.white), // Use the textColor parameter
      ),
    );
  }
}
