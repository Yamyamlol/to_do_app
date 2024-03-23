import 'package:flutter/material.dart';
import 'package:to_do_app/data/database.dart';
import 'package:to_do_app/util/dialog_box.dart';
import 'package:to_do_app/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  late ToDoDatabase db;

  @override
  void initState() {
    super.initState();
    db = ToDoDatabase();
    if (db.toDoList.isEmpty) {
      db.initializeData();
    } else {
      db.loadData();
    }
  }

  void saveNewTask() {
    setState(() {
      if (_controller.text.isNotEmpty) {
        db.toDoList.add([_controller.text, false]);
        db.updateDataBase();
      }
    });
    Navigator.of(context).pop();
    _controller.clear();
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
      db.updateDataBase();
    });
  }

  void editTaskName(String oldTaskName, String newTaskName) {
    setState(() {
      for (int i = 0; i < db.toDoList.length; i++) {
        if (db.toDoList[i][0] == oldTaskName) {
          db.toDoList[i][0] = newTaskName;
          break;
        }
      }
      db.updateDataBase();
    });
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onDiscard: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = value ?? false;
      db.updateDataBase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        backgroundColor: Colors.yellow[400],
        title: Text(
          'T O D O',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        backgroundColor: Colors.yellow[600],
        child: Icon(Icons.add),
        shape: CircleBorder(),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.toDoList[index][0],
            taskDescription: "",
            taskCompleted: db.toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
            editTaskName: (newTaskName) =>
                editTaskName(db.toDoList[index][0], newTaskName),
          );
        },
      ),
    );
  }
}
