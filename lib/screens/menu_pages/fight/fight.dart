import 'package:flutter/material.dart';

class Fight extends StatelessWidget {
  const Fight({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container (
      child: const Text(
        'Hello',
        style: TextStyle(color: Colors.red),
      ),
    );
  }
}