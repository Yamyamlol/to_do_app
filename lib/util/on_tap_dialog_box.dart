import 'package:flutter/material.dart';

class OnTapDialogBox extends StatelessWidget {
  final String taskName;
  final String taskDescription;

  OnTapDialogBox({
    required this.taskName,
    required this.taskDescription,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        taskName,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        taskDescription,
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
      ],
    );
  }
}
