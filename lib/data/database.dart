import 'package:hive/hive.dart';

class  ToDoDatabase{

  List toDoList = []; 

  //reference the box
  final _myBox = Hive.box('MYBOX');

  // RUN THIS METHOD IF THIS IS THE FIRST TIME OPENING THE APP
  void initializeData()
  {
    toDoList = [
      ["support me", false],
      ["give feedback", false],
    ];
  }

  //load the data from database
  void loadData(){
    toDoList = _myBox.get("TODOLIST");
  }

  //update the database
  void updateDataBase(){
    _myBox.put("TODOLIST", toDoList);
  }

}