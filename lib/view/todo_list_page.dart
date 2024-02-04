import 'package:flutter/material.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  ToDoListState createState() => ToDoListState();
}

class ToDoListState extends State<ToDoList> {
  final List<Map<String, dynamic>> _todoList = [];
  TextEditingController _textFieldController = TextEditingController();

  // アイテム追加
  void _addToDoItem(String task) {
    setState(() {
      _todoList.add({'task': task, 'isChecked': false});
    });
    _textFieldController.clear();
  }

  // アイテム削除
  void _deleteToDoItem(int index) {
    setState(() {
      _todoList.removeAt(index);
    });
    _textFieldController.clear();
  }

  // アイテム編集
  void _editToDoItem(int index) {
    setState(() {
      _todoList[index]['task'] = _textFieldController.text;
    });
    _textFieldController.clear();
  }

  // ToDoリストの生成
  Widget _buildToDoList() {
    return ListView.builder(
      itemCount: _todoList.length,
      itemBuilder: (context, index) {
        return _buildToDoItem(_todoList[index], index);
      },
    );
  }

  Widget _buildToDoItem(Map data, int index) {
    return GestureDetector(
      onLongPress: () {
        _displayDialog(context, index);
      },
      child: CheckboxListTile(
        tileColor: Colors.black12,
        title: Text(
          data['task'],
          style: TextStyle(
            fontSize: 20,
            fontWeight: data['isChecked'] ? FontWeight.bold : FontWeight.normal,
            color: data['isChecked'] ? Colors.blue : Colors.black,
          ),
        ),
        secondary: IconButton(
          icon: const Icon(
            Icons.delete,
            color: Colors.black45,
          ),
          onPressed: () => _deleteToDoItem(index),
        ),
        controlAffinity: ListTileControlAffinity.leading,
        value: data['isChecked'],
        onChanged: (bool? value) {
          setState(() {
            data['isChecked'] = value;
          });
        },
        activeColor: Colors.blue[500],
      )
    );
  }

  Future<void> _displayDialog(BuildContext context, int? index) async {
    _textFieldController = TextEditingController(text: index == null ? '' : _todoList[index]['task']);
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
              child: Text(index == null ? 'Add' : 'Save'),
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
