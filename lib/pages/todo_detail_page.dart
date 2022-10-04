import 'package:flutter/material.dart';

enum TodoAction { rename, delete }

class TodoEditResult {
  final TodoAction todoAction;
  final String? newName;

  const TodoEditResult({required this.todoAction, this.newName});
}

class Validations {
  static String? Function(String? value) minLength(
      {required int min, String? customErrorMessage}) {
    String errorMessage = customErrorMessage ?? "$min文字以上で入力してください。";

    validation(String? value) {
      if (value == null || value.length < min) {
        return errorMessage;
      } else {
        return null;
      }
    }

    return validation;
  }
}

class TodoDetailPage extends StatefulWidget {
  final String todoName;
  const TodoDetailPage({super.key, required this.todoName});

  @override
  TodoDetailPageState createState() => TodoDetailPageState();
}

class TodoDetailPageState extends State<TodoDetailPage> {
  String newTodoName = '';

  final _formKey = GlobalKey<FormState>();
  bool _enableButton = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TodoDetailPage'),
      ),
      body: Column(
        children: [
          const Text('Taskname'),
          Form(
            key: _formKey,
            onChanged: () {
              setState(() {
                _enableButton = _formKey.currentState!.validate();
              });
            },
            child: ListView(
              // 入れ子にする場合は、高さが無制限になってしまいエラーになるので対応。
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                TextFormField(
                  // ユーザが入力したときに値をチェックする
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: Validations.minLength(min: 1),
                  initialValue: widget.todoName,
                  onChanged: (value) {
                    setState(() {
                      newTodoName = value;
                    });
                  },
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: !_enableButton
                ? null
                : (() {
                    TodoEditResult todoEditResult = TodoEditResult(
                      todoAction: TodoAction.rename,
                      // 一度も入力値が変わっていない場合はnewTodoNameは空
                      newName:
                          newTodoName == '' ? widget.todoName : newTodoName,
                    );

                    Navigator.of(context).pop(todoEditResult);
                  }),
            child: const Text('適用'),
          ),
          TextButton(
              onPressed: () {
                TodoEditResult todoEditResult = const TodoEditResult(
                  todoAction: TodoAction.delete,
                );

                Navigator.of(context).pop(todoEditResult);
              },
              child: const Text('削除'))
        ],
      ),
    );
  }
}
