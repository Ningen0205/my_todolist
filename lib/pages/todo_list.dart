import 'package:flutter/material.dart';
import 'package:my_todolist/logics/datastore.dart';
import 'package:my_todolist/pages/todo_add.dart';

import 'package:my_todolist/pages/option.dart';

import 'package:firebase_auth/firebase_auth.dart';

class TodoListPage extends StatefulWidget {
  User user;

  TodoListPage({super.key, required this.user});

  @override
  TodoListPageState createState() => TodoListPageState();
}

class TodoListPageState extends State<TodoListPage> {
  List<Todo> todoList = [];

  Widget _buildListItem(BuildContext context, int index) {
    return Card(
      child: ListTile(
        title: Text(todoList[index].text),
        onTap: () async {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TodoList'),
      ),
      drawer: Drawer(
        child: Center(
          child: Column(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const OptionPage(),
                    ),
                  );
                },
                child: const Text('Options'),
              )
            ],
          ),
        ),
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
          await Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => TodoAddPage(user: widget.user)),
          );

          setState(() async {
            await TodoStoreLogic().getTodos(widget.user);
          });
          var test = await TodoStoreLogic().getTodos(widget.user);

          print(test);
        },
      ),
    );
  }
}
