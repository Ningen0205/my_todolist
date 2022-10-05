import 'package:flutter/material.dart';
import 'package:matcher/matcher.dart';
import 'package:my_todolist/pages/user_login.dart';

class OptionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Option')),
      // drawer: Drawer(
      //   child: Center(
      //     child: Column(children: [
      //       TextButton(onPressed: () {
      //         Navigator.of(context).
      //       }, child: const Text('Options'))
      //     ]),
      //   ),
      // ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.red),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const UserLoginPage(),
                  ),
                  (_) => false,
                );
              },
              child: const Text('Logout'),
            )
          ],
        ),
      ),
    );
  }
}
