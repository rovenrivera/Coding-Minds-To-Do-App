import 'package:coding_minds_bootstrap/util/newtask_dialog.dart';
import 'package:coding_minds_bootstrap/util/work_todo_block.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coding_minds_bootstrap/auth.dart';

// Work To Do List Page

class WorkPage extends StatefulWidget {
  const WorkPage({super.key});

  @override
  State<WorkPage> createState() => _WorkPageState();
}

class _WorkPageState extends State<WorkPage> {

  final fireStore = FirebaseFirestore.instance;
 List workToDoList = [
  ];
  Future<void> signOut() async {
    await Auth().signOut();
  }
  void checkBoxTapped(bool? value, int index){
    setState(() {
      workToDoList[index][1] = !workToDoList[index][1];
    });
  }
  void saveNewTask () {
    setState(() {
      if (_controller.text.isEmpty) {
        _controller.clear();
      }
      else {
        workToDoList.add([_controller.text, false]);
        FirebaseFirestore.instance.collection('workTasks').doc(_controller.text).set({
            'taskName': _controller.text,
            'taskComplete': false,
        },);
        _controller.clear();
      }
    });
    Navigator.of(context).pop();
  }
  void cancelNewTask () {
    Navigator.of(context).pop();
     _controller.clear();
  }
  void newTask () {
    showDialog(
      context: context, 
      builder: (context) {
        return NewTaskDialog(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: cancelNewTask,
        );
      }
    );
  }
  void deleteTask(int index) {
    setState(() {
      FirebaseFirestore.instance.collection('workTasks').doc(workToDoList[index]['taskName'].toString()).delete();
      workToDoList.removeAt(index);
    });
  }
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: fireStore.collection('workTasks').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.docs.isEmpty) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.green,
                title: const Text('To Do: School'),
                titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: newTask,
                shape: const CircleBorder(),
                backgroundColor: Colors.green,
                child: const Icon(
                  Icons.add, 
                  color: Colors.white, 
                  shadows: [
                    Shadow(
                      offset: Offset(1.0, 1.0),
                      blurRadius: 5.0,
                      color: Color.fromARGB(70, 0, 0, 0)
                    )
                  ],
                ),
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(
                    child: Text('Nothing here, start with a new task!', style: TextStyle(color: Color.fromARGB(87, 56, 56, 56)),)
                  ),
                  SizedBox(height: 20,),
                  Center(
                    child: ElevatedButton(
                      style: const ButtonStyle(
                        overlayColor: WidgetStatePropertyAll(Color.fromARGB(37, 74, 173, 77))
                      ),
                      onPressed: signOut,
                      child: const Text('Sign Out', style: TextStyle(color: Colors.green),)
                    ),
                  )
                ],
              )
            );
          }
          else {
            workToDoList = snapshot.data!.docs.cast<dynamic>().toList();
            return Scaffold( 
              appBar: AppBar(
                backgroundColor: Colors.green,
                title: Text('To Do: Work'),
                titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: newTask,
                shape: CircleBorder(),
                backgroundColor: Colors.green,
                child: const Icon(
                  Icons.add, 
                  color: Colors.white, 
                  shadows: [
                    Shadow(
                      offset: Offset(1.0, 1.0),
                      blurRadius: 5.0,
                      color: Color.fromARGB(70, 0, 0, 0)
                    )
                  ],
                ),
              ),
              body: Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (context, index) {
                        return WorkToDoBlock(
                          taskName: snapshot.data?.docs[index]['taskName'].toString() ?? 'default',
                          taskComplete: snapshot.data?.docs[index]['taskComplete'],
                          onChanged: (value) => checkBoxTapped(value, index),
                          deleteTask: (context) => deleteTask(index),
                       );
                      },
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                      style: const ButtonStyle(
                        overlayColor: WidgetStatePropertyAll(Color.fromARGB(37, 74, 173, 77))
                      ),
                      onPressed: signOut,
                      child: const Text('Sign Out', style: TextStyle(color: Colors.green),)
                    ),
                  ),
                  SizedBox(height: 20,)
                ]
              )
            );
          }
        }
        else {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.green,
              title: const Text('To Do: Work'),
              titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                  child: CircularProgressIndicator(
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 20,),
                Center(
                  child: ElevatedButton(
                    style: const ButtonStyle(
                      overlayColor: WidgetStatePropertyAll(Color.fromARGB(37, 74, 173, 77))
                    ),
                    onPressed: signOut,
                    child: const Text('Sign Out', style: TextStyle(color: Colors.green),)
                  ),
                ),
              ],
            )
          );
        }
      }
    );
  }
}