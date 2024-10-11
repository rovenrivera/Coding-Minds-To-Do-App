import 'package:coding_minds_bootstrap/util/mybutton.dart';
import 'package:flutter/material.dart';

// Dialog box that pops up when user needs to create a new task

// ignore: must_be_immutable
class NewTaskDialog extends StatelessWidget {

  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  NewTaskDialog(
    {
      super.key,
      required this.controller,
      required this.onSave,
      required this.onCancel
    }
  );

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // Alert box
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0))
      ),
      backgroundColor: const Color.fromARGB(255, 83, 166, 86),
      content: Container(
        height: 150,
        width: 500,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Input field for user to name new task
            TextField(
              controller: controller,
              cursorColor: const Color.fromARGB(255, 29, 52, 30),
              style: const TextStyle(
                color: Color.fromARGB(255, 20, 49, 21)
              ),
              decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 29, 52, 30)
                  )
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 29, 52, 30),
                    width: 2.0,
                  )
                ),
                hintText: "Create a new task", 
                hintStyle: TextStyle(
                  color: Color.fromARGB(110, 14, 35, 14)
                ),
              ),
            ),

            // Spacer
            const SizedBox(height: 12),

            // Buttons to save the task or cancel making the task
            Row(
              children: [
                //save
                MyButton(
                  text: 'Save',
                  onPressed: onSave,
                ),

                //spacer
                const SizedBox(width: 12),

                //cancel
                MyButton(
                  text: 'Cancel',
                  onPressed: onCancel,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}