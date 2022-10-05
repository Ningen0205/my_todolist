import 'package:flutter/material.dart';
import 'package:my_todolist/pages/todo_add.dart';
import 'package:my_todolist/pages/todo_detail.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  TodoListPageState createState() => TodoListPageState();
}

class TodoListPageState extends State<TodoListPage> {
  List<String> todoList = [];

  Widget _buildListItem(BuildContext context, int index) {
    return Card(
      child: ListTile(
        title: Text(todoList[index]),
        onTap: () async {
          TodoEditResult? todoEditResult =
              await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => TodoDetailPage(todoName: todoList[index]),
          ));

          if (todoEditResult == null) return;

          if (todoEditResult.todoAction == TodoAction.rename &&
              todoEditResult.newName != null) {
            setState(() {
              todoList[index] = todoEditResult.newName!;
            });
          }

          if (todoEditResult.todoAction == TodoAction.delete) {
            setState(() {
              todoList.removeAt(index);
            });
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TodoList'),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: todoList.length,
          itemBuilder: _buildListItem,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final String? todoText = await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const TodoAddPage()),
          );

          // 空文字 or nullは追加しない
          if (todoText == null || todoText == '') return;

          // setStateで囲わないと再描画されなさそう
          setState(() {
            todoList.add(todoText);
          });
        },
      ),
    );
  }
}
