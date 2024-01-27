import 'package:flutter/material.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  final List<String> _todoList = [];
  final TextEditingController _textFieldController = TextEditingController();

  void _addToDoItem(String task) {
    setState(() {
      _todoList.add(task);
    });
    _textFieldController.clear();
  }

  void _removeToDoItem(String task) {
    setState(() {
      _todoList.remove(task);
    });
  }

  Widget _buildToDoList() {
    return ListView.builder(
      itemCount: _todoList.length,
      itemBuilder: (context, index) {
        return _buildToDoItem(_todoList[index]);
      },
    );
  }

  Widget _buildToDoItem(String title) {
    return ListTile(
      title: Text(title),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () => _removeToDoItem(title),
      ),
    );
  }

  Future<void> _displayDialog(BuildContext context) async {
    showDialog<AlertDialog>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Todoを追加'),
          content: TextField(
            controller: _textFieldController,
            decoration: const InputDecoration(hintText: 'ここに入力'),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Add'),
              onPressed: () {
                _addToDoItem(_textFieldController.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo List'),
      ),
      body: _buildToDoList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _displayDialog(context),
        tooltip: 'Add Item',
        child: const Icon(Icons.add),
      ),
    );
  }
}
