import 'package:flutter/material.dart';

class OnTapDialogBox extends StatefulWidget {
  final String taskName;
  final String taskDescription;
  final Function(String) onEdit; // Callback function to pass the edited task name

  OnTapDialogBox({
    required this.taskName,
    required this.taskDescription,
    required this.onEdit,
  });

  @override
  _OnTapDialogBoxState createState() => _OnTapDialogBoxState();
}

class _OnTapDialogBoxState extends State<OnTapDialogBox> {
  late TextEditingController _taskNameController;
  late String _newTaskName;

  @override
  void initState() {
    super.initState();
    _taskNameController = TextEditingController(text: widget.taskName);
    _newTaskName = widget.taskName;
  }

  @override
  void dispose() {
    _taskNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: TextField(
          controller: _taskNameController,
          onChanged: (newValue) {
            setState(() {
              _newTaskName = newValue;
            });
          },
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
          ),
        ),
      ),
      content: Text(
        widget.taskDescription,
        style: TextStyle(
          fontSize: 16,
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Close'),
        ),
        TextButton(
          onPressed: () {
            // Save the new task name and pass it back to the callback function
            widget.onEdit(_newTaskName);
            Navigator.of(context).pop();
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}
