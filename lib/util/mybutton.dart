import 'package:flutter/material.dart';

// Button skeleton for save/cancel buttons in "newtask_dialog.dart"

// ignore: must_be_immutable
class MyButton extends StatelessWidget {
  final String text;
  VoidCallback onPressed;
  MyButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: const Color.fromARGB(255, 66, 145, 71),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6)
      ),
      child: Text(
        text, 
        style: const TextStyle(
          color: Color.fromARGB(255, 20, 49, 21)
        )
      ),
    );
  }
}