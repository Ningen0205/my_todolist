import 'package:flutter/material.dart';
import 'package:my_todolist/pages/user_login.dart';

class OptionPage extends StatelessWidget {
  const OptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Option')),
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
