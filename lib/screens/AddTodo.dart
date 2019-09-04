import 'package:flutter/material.dart';
import 'package:flutter_moor_sqlite/db/my_database.dart';

class AddTodo extends StatefulWidget {
  @override
  _AddTodoState createState() => _AddTodoState();
}

String text = "";

class _AddTodoState extends State<AddTodo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add ToDo"),
      ),
      body: Column(
        children: <Widget>[TextField(
          onChanged: (value) {
            text = value;
          },
        ),
          RaisedButton(
            onPressed: () async {
              await MyDatabase.instance.addTodo(Todo(description: text, completed: false));
              Navigator.pop(context);
            },
            child: Text("Adicionar"),
          )
        ],
      ),
    );
  }
}
