import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:my_todolist/logics/datastore.dart';

class TodoAddPage extends StatefulWidget {
  final User user;

  const TodoAddPage({super.key, required this.user});

  @override
  TodoAddPageState createState() => TodoAddPageState();
}

class TodoAddPageState extends State<TodoAddPage> {
  String text = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TodoAddPage')),
      body: Column(
        children: [
          const Text('Task name'),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  text = value;
                });
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
              child: const Text('追加'),
              onPressed: () async {
                await TodoStoreLogic().addTodo(widget.user, text);

                if (!mounted) return;

                Navigator.of(context).pop();
              },
            ),
          )
        ],
      ),
    );
  }
}
