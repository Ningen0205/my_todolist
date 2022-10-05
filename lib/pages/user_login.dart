import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:my_todolist/pages/todo_list.dart';
import 'package:my_todolist/pages/user_register.dart';
import 'package:my_todolist/utils/validator.dart';

class UserLoginPage extends StatefulWidget {
  const UserLoginPage({super.key});

  @override
  UserLoginPageState createState() => UserLoginPageState();
}

class UserLoginPageState extends State<UserLoginPage> {
  final _formKey = GlobalKey<FormState>();

  bool _enableButton = false;

  String inputEmail = '';
  String inputPassword = '';

  String _loginErrorText = '';

  void _pressedLoginButton() async {
    try {
      final UserCredential credential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: inputEmail,
        password: inputPassword,
      );

      if (!mounted) return;

      print('test');

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const TodoListPage()),
      );
    } on FirebaseAuthException catch (e) {
      print('error');

      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        setState(() {
          _loginErrorText = 'Incorrect email address or password';
        });
      } else {
        setState(() {
          _loginErrorText = e.toString();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
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
                      validator: Validators.minLength(min: 1),
                      onChanged: (value) {
                        setState(() {
                          inputPassword = value;
                        });
                      }),
                  ElevatedButton(
                    onPressed: _enableButton ? _pressedLoginButton : null,
                    child: const Text('Login'),
                  ),
                  Text(
                    _loginErrorText,
                    style: const TextStyle(color: Colors.red),
                  )
                ],
              ),
            ),
            TextButton(
              child: const Text('Signin'),
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: ((context) => const UserRegisterPage()),
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
