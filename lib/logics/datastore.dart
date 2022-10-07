import 'package:my_todolist/consts.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  final String id;
  final String userId;
  final String text;
  final String state;

  const Todo(
      {required this.id,
      required this.userId,
      required this.text,
      required this.state});
}

enum TodoFields { userId, text, state }

class TodoStoreLogic {
  final db =
      FirebaseFirestore.instance.collection(FireStoreCollections.todos.name);

  Todo _convertTodo(Map<String, dynamic> todo, String documentId) {
    return Todo(
      id: documentId,
      userId: todo[TodoFields.userId],
      text: todo[TodoFields.text],
      state: todo[TodoFields.state],
    );
  }

  Future<Todo?> getTodo(User user, String documentId) async {
    var result = await db.doc(documentId).get();

    var todo = result.data();

    if (todo == null) return null;

    return _convertTodo(todo, result.id);
  }

  Future<List<Todo>> getTodos(User user) async {
    var result = await db.where('userId', isEqualTo: user.uid).get();

    var convertedTodos = result.docs.map(
      (snapshot) {
        var data = snapshot.data();
        return _convertTodo(data, snapshot.id);
      },
    ).toList();

    return convertedTodos;
  }

  Future<Todo> addTodo(User user, String text) async {
    var result = await db.add(
        {"userId": user.uid, "text": text, "state": TodoState.progress.name});

    var todo = await getTodo(user, result.id);

    return todo!;
  }
}
