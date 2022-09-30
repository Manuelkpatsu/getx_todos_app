import 'package:flutter/material.dart';

class TodoListScreen extends StatelessWidget {
  static const routeName = '/';

  const TodoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Todo List Screen'),
      ),
    );
  }
}
