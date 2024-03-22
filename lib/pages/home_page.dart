import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:to_do_app/data/database.dart';
import 'package:to_do_app/util/dialog_box.dart';
import 'package:to_do_app/util/todo_tile.dart';

class HomePage extends StatefulWidget
{
  const HomePage({super.key});

  @override
  State <HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
    
    //reference the hive box
    final _myBox = Hive.box('MYBOX');

    //instantiate the database
    ToDoDatabase db = ToDoDatabase(); //TODO this creates an instance of this class as we declared in the database file

    @override
    void initState(){
      // if this is the first time ever initiate the app
      if(_myBox.get("TODOLIST") == null)
        db.initializeData();
      else
        db.loadData();
    }

    //text controller
    final _controller = TextEditingController();

    //! list of todo tasks
    //! List toDoList = [
    //!   ["Make Tutorial", false],
    //!   ["Exercise", false],
    //! ];

    //save new task
    void saveNewTask(){
      setState(() {
        db.toDoList.add([_controller.text, false]);
      });
      Navigator.of(context).pop();
      _controller.clear();
    }

    //delete task
    void deleteTask(int index)
    {
      setState(() {
        db.toDoList.removeAt(index);
      });
      db.updateDataBase();
    }

    //create new task
    void createNewTask()
    {
      showDialog(context: context, builder: (context){
        return DialogBox(
          controller:_controller,
          onSave: saveNewTask,
          onDiscard: () => Navigator.of(context).pop(),
          );
      });
    }

    // checkbox was tapped
    void checkBoxChanged(bool? value, int index)
    {
      setState(() {
        db.toDoList[index][1] = !db.toDoList[index][1];
      });
      db.updateDataBase();
    }

  @override


  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        backgroundColor: Colors.yellow[400],
        title: Text(
          'T O    D O', 
          style: TextStyle(
            fontWeight: FontWeight.bold
            ),
          ),
        centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewTask,
          backgroundColor: Colors.yellow[600],
          child:Icon(Icons.add),
          shape: CircleBorder(),
        ),
        body: ListView.builder(
          itemCount: db.toDoList.length,
          itemBuilder: (context, index)
          {
            return ToDoTile(
              taskName: db.toDoList[index][0], 
              TaskCompleted: db.toDoList[index][1], 
              onChanged: (value) => checkBoxChanged(value, index),
              deleteFunction: (context) => deleteTask(index),
            );
          }
      ),
    );
  }
} 