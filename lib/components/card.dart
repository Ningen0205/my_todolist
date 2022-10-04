import 'package:flutter/material.dart';

class Card extends StatefulWidget {
  final String text;
  final Function() onPressed;

  const Card({super.key, required this.text, required this.onPressed});

  @override
  CardState createState() => CardState();
}

class CardState extends State<Card> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: widget.onPressed,
          child: Text(widget.text),
        ),
      ),
    );
  }
}
