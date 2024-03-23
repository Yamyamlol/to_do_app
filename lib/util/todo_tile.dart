import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:to_do_app/util/on_tap_dialog_box.dart';

class ToDoTile extends StatelessWidget {
  final String taskName;
  final String taskDescription;
  final bool taskCompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? deleteFunction;
  final Function(String) editTaskName; // New callback for editing task name

  ToDoTile({
    Key? key,
    required this.taskName,
    required this.taskDescription,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
    required this.editTaskName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return OnTapDialogBox(
              taskName: taskName,
              taskDescription: taskDescription,
              onEdit: editTaskName, // Pass the edit task name callback
            );
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
        child: Slidable(
          endActionPane: ActionPane(
            motion: StretchMotion(),
            children: [
              SlidableAction(
                borderRadius: BorderRadius.circular(12),
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
                  value: taskCompleted,
                  activeColor: Colors.yellow[900],
                  onChanged: onChanged,
                ),
                Text(
                  taskName,
                  style: TextStyle(
                    fontSize: 18,
                    decoration: taskCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.yellow,
              borderRadius: BorderRadius.circular(18),
            ),
          ),
        ),
      ),
    );
  }
}
