import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Initializes task blocks

// ignore: must_be_immutable
class WorkToDoBlock extends StatefulWidget {

  final String taskName;
  bool taskComplete;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteTask;
  WorkToDoBlock({super.key, required this.taskName, required this.taskComplete, required this.onChanged, required this.deleteTask});

  @override
  State<WorkToDoBlock> createState() => _WorkToDoBlockState();
}

class _WorkToDoBlockState extends State<WorkToDoBlock> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 25, 25, 5),

      // "Slidable" is an imported flutter dependency,
      // allowing task to be deleted by sliding to left on task.
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            // Delete buttton that shows up on sliding to the left
            SlidableAction(
              borderRadius: BorderRadius.circular(5),
              onPressed: widget.deleteTask,
              icon: Icons.delete,
              backgroundColor: const Color.fromARGB(255, 178, 47, 37),
            )
          ],
        ),
        // Task block
        child: Container(
          height: 75,
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            children: [
        
              // Check off the task
              Checkbox(
                value: widget.taskComplete, 
                onChanged: (bool? newValue) {
                  setState(() {
                    widget.taskComplete = newValue!;
                    FirebaseFirestore.instance.collection('workTasks').doc(widget.taskName).set({
                      'taskName': widget.taskName,
                      'taskComplete': widget.taskComplete,
                      },);
                  });
                },
                activeColor: const Color.fromARGB(255, 29, 52, 30),
                side: const BorderSide(
                  color: Colors.white,
                  width: 2.0,
                ),
              ),
        
              // Name of task
              Text(
                widget.taskName,
                style: TextStyle(
                  decoration: widget.taskComplete
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                  shadows: const <Shadow>[
                    Shadow(
                      offset: Offset(1.0, 1.0),
                      blurRadius: 5.0,
                      color: Color.fromARGB(70, 0, 0, 0)
                    )
                  ],
                  color: widget.taskComplete
                    ? Color.fromARGB(255, 29, 52, 30)
                    : Colors.white,
                  fontSize: 16,
                )
              ),
            ]
          ),
        ),
      ),
    );
  }
}