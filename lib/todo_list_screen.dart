import 'package:flutter/material.dart';
import 'add_edit_task_screen.dart';
import 'task.dart';

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<Task> tasks = [];

  void _addOrEditTask(Task task, [int? index]) {
    setState(() {
      if (index == null) {
        tasks.add(task); 
      } else {
        tasks[index] = task; 
      }
    });
  }


  void _deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo List'),
        backgroundColor: Colors.blueGrey,
      ),
      body: tasks.isEmpty
          ? Center(
              child: Text(
                'No tasks available. Add a task!',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    title: Text(
                      tasks[index].title,
                      style: TextStyle(
                        fontSize: 18,
                        decoration: tasks[index].isCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blueGrey),
                          onPressed: () async {
                            Task? updatedTask = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AddEditTaskScreen(task: tasks[index]),
                              ),
                            );
                            if (updatedTask != null) {
                              _addOrEditTask(updatedTask, index);
                            }
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteTask(index),
                        ),
                      ],
                    ),
                    leading: Checkbox(
                      value: tasks[index].isCompleted,
                      onChanged: (newValue) {
                        setState(() {
                          tasks[index].isCompleted = newValue!;
                        });
                      },
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Task? newTask = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEditTaskScreen(),
            ),
          );
          if (newTask != null) {
            _addOrEditTask(newTask);
          }
        },
        backgroundColor: Colors.blueGrey,
        child: Icon(Icons.add),
      ),
    );
  }
}
