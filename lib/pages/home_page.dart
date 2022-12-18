import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_with_hive/data/database.dart';
import 'package:todo_with_hive/widgets/dialog_box.dart';
import 'package:todo_with_hive/widgets/list_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();
  final _myBox = Hive.box('mybox');
  Database db = Database();

  void _checkBoxChanged(bool? value, int index) {
    setState(() {
      db.todoList[index][1] = !db.todoList[index][1];
    });
    db.updateData();
  }

  void _createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller,
            onSave: _saveNewTask,
            onCancel: () => Navigator.of(context).pop(),
          );
        });
  }

  void _deleteTask(int index) {
    setState(() {
      db.todoList.removeAt(index);
    });
    db.updateData();
  }

  void _saveNewTask() {
    setState(() {
      db.todoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateData();
  }

  @override
  void initState() {
    super.initState();
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[200],
      appBar: AppBar(
        title: const Text('Todo'),
        centerTitle: true,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createNewTask,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListItem(
            taskName: db.todoList[index][0],
            taskCompeted: db.todoList[index][1],
            onChanged: (value) => _checkBoxChanged(value, index),
            deleteFunction: (context) => _deleteTask(index),
          );
        },
        itemCount: db.todoList.length,
      ),
    );
  }
}
