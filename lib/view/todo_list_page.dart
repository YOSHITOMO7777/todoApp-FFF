import 'package:flutter/material.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  final List<String> _todoList = [];
  TextEditingController _textFieldController = TextEditingController();

  void _addToDoItem(String task) {
    setState(() {
      _todoList.add(task);
    });
    _textFieldController.clear();
  }

  void _deleteToDoItem(int index) {
    setState(() {
      _todoList.removeAt(index);
    });
    _textFieldController.clear();
  }

  void _editToDoItem(int index) {
    setState(() {
      _todoList[index] = _textFieldController.text;
    });
    _textFieldController.clear();
  }

  Widget _buildToDoList() {
    return ListView.builder(
      itemCount: _todoList.length,
      itemBuilder: (context, index) {
        return _buildToDoItem(_todoList[index], index);
      },
    );
  }

  Widget _buildToDoItem(String title, int index) {
    return ListTile(
      tileColor: Colors.blue[900],
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
      ),
      onTap: () {
        _displayDialog(context, index);
      },
      trailing: IconButton(
        icon: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
        onPressed: () => _deleteToDoItem(index),
      ),
    );
  }

  Future<void> _displayDialog(BuildContext context, int? index) async {
    _textFieldController = TextEditingController(text: index == null ? '' : _todoList[index]);
    showDialog<AlertDialog>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(index == null ? 'Todoを追加' : 'Todoを編集'),
          content: TextField(
            controller: _textFieldController,
            decoration: const InputDecoration(hintText: 'ここに入力'),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text(index == null ? 'Add' : 'Edit'),
              onPressed: () {
                if(index == null) {
                  _addToDoItem(_textFieldController.text);
                } else {
                  _editToDoItem(index);
                }
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
        onPressed: () => _displayDialog(context, null),
        tooltip: 'Add Item',
        child: const Icon(Icons.add),
      ),
    );
  }
}
