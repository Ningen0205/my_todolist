import 'package:flutter/material.dart';

import 'package:my_todolist/pages/user_login.dart';
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

  void _pressedRegisterButton() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signin'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              child: Form(
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
                    ),
                    ElevatedButton(
                      onPressed: _enableButton ? _pressedRegisterButton : null,
                      child: const Text('Login'),
                    ),
                    Text(
                      _registerErrorText,
                      style: TextStyle(color: Colors.red),
                    )
                  ],
                ),
              ),
            ),
            Container(
              child: TextButton(
                child: const Text('Login'),
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: ((context) => const UserLoginPage()),
                  ));
                },
              ),
            )
          ],
        ),
      ),
    );
    ;
  }
}
