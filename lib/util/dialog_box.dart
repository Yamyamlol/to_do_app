import 'package:flutter/material.dart';
import 'package:to_do_app/util/my_button.dart';

class DialogBox extends StatelessWidget
{
  final controller;
  VoidCallback onSave;
  VoidCallback onDiscard;


  DialogBox({
    super.key, 
    required this.controller,
    required this.onSave,
    required this.onDiscard,
  });
  @override
  Widget build(BuildContext context)
  {
    return AlertDialog(
      backgroundColor: Colors.yellow,
      content: Container(
        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.7),
        height:150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(

              child: TextField(
              controller: controller,
              maxLines: null,
              decoration: InputDecoration(border: OutlineInputBorder(),
              hintText: "Add a New Task"),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MyButton(text: "Save", onPressed: onSave),
              MyButton(text: "Discard", onPressed: onDiscard),
            ],
          )

        ],)
      )
    );

  }
}

