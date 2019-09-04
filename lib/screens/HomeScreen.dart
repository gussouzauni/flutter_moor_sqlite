import 'package:flutter/material.dart';
import 'package:flutter_moor_sqlite/db/my_database.dart';
import 'package:flutter_moor_sqlite/screens/AddTodo.dart';

///https://pub.dev/packages/moor_flutter
///https://www.youtube.com/watch?v=ATNJ7g-y-wo - SQL reativo

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sqlite + moor_flutter'),
      actions: <Widget>[
        IconButton(icon: Icon(Icons.add), onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AddTodo()));
        },)
      ],
      ),
      body: StreamBuilder<List<Todo>>(
        stream: MyDatabase.instance.getAllTodos(),
        initialData: [],
        builder: (context, snapshot) {
          //Streambuilder vai receber aquele metodo getAllTodos
          List<Todo> list = snapshot.data;
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              return ListTile( //Retornar os itens da lista em forma de ListTile
                leading: IconButton(icon: Icon(Icons.delete), onPressed: () {
                  MyDatabase.instance.deleteTodo(list[index].id);
                },),
                title: Text(list[index].description),
              );
            },
          );
        },
      ),
    );
  }
}
