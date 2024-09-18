import 'package:flutter/material.dart';
import 'todo_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDo List App',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: TodoListScreen(),
    );
  }
}
