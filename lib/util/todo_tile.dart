import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';


class ToDoTile extends StatelessWidget
{
  final String taskName;
  final bool TaskCompleted;
  Function(bool?)? onChanged;

  //delete function
  Function(BuildContext)? deleteFunction;

  ToDoTile ({
    super.key,
    required this.taskName,
    required this.TaskCompleted,
    required this.onChanged,
    required this.deleteFunction,
    });

  @override

  Widget build(BuildContext context)
  {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              borderRadius: BorderRadius.circular((12)),
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.red,
            )
          ],

        ),
        child: Container(
          padding: EdgeInsets.all(24),
          child: Row(
            children: [
              Checkbox(
                value: TaskCompleted,
                activeColor: Colors.yellow[900],
                onChanged: onChanged,
        
              ),
              Text(
                taskName,
                style: TextStyle(
                  fontSize: 18,
                  // fontWeight: FontWeight.bold,
                  decoration: TaskCompleted? TextDecoration.lineThrough: TextDecoration.none
                )
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: Colors.yellow,
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }
}