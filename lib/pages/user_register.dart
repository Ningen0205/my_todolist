import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:my_todolist/pages/user_login.dart';
import 'package:my_todolist/pages/todo_list.dart';
import 'package:my_todolist/utils/validator.dart';

class UserRegisterPage extends StatefulWidget {
  const UserRegisterPage({super.key});

  @override
  UserRegisterPageState createState() => UserRegisterPageState();
}

class UserRegisterPageState extends State<UserRegisterPage> {
  final _formKey = GlobalKey<FormState>();

  bool _enableButton = false;

  String inputEmail = '';
  String inputPassword = '';

  String _registerErrorText = '';

  void _pressedRegisterButton() async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: inputEmail,
        password: inputPassword,
      );

      User? user = credential.user;

      if (user == null) {
        setState(() {
          _registerErrorText = 'Failed to get user information.';
        });

        return;
      }

      if (!mounted) return;

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => TodoListPage(user: user)),
      );
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      if (e.code == 'weak-password') {
        setState(() {
          _registerErrorText = 'The password provided is too weak.';
        });
      } else if (e.code == 'email-already-in-use') {
        setState(() {
          _registerErrorText = 'The account already exists for that email.';
        });
      } else {
        setState(() {
          _registerErrorText = 'unknown error';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signup'),
      ),
      body: Center(
        child: Column(
          children: [
            Form(
              onChanged: () {
                setState(() {
                  _enableButton = _formKey.currentState!.validate();
                });
              },
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(20),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  TextFormField(
                    decoration:
                        const InputDecoration(hintText: "email address"),
                    keyboardType: TextInputType.emailAddress,
                    validator: Validators.email(),
                    onChanged: (value) {
                      setState(() {
                        inputEmail = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(hintText: "password"),
                    obscureText: true,
                    validator: Validators.mixin(validators: [
                      Validators.minLength(
                        min: 8,
                        customErrorMessage: "英大文字、英小文字、数字を含んだ8文字以上にしてください。",
                      ),
                      Validators.exists(charSets: [
                        Charset.lowerAlphabet,
                        Charset.upperAlphabet,
                        Charset.number,
                      ], errorText: "英大文字、英小文字、数字を含んだ8文字以上にしてください。")
                    ]),
                    onChanged: ((value) {
                      setState(() {
                        inputPassword = value;
                      });
                    }),
                  ),
                  ElevatedButton(
                    onPressed: _enableButton ? _pressedRegisterButton : null,
                    child: const Text('Signup'),
                  ),
                  Text(
                    _registerErrorText,
                    style: const TextStyle(color: Colors.red),
                  )
                ],
              ),
            ),
            TextButton(
              child: const Text('Login'),
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: ((context) => const UserLoginPage()),
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
