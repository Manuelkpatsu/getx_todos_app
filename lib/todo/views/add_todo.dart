import 'package:flutter/material.dart';

class AddTodoScreen extends StatelessWidget {
  static const routeName = '/add_todo';

  const AddTodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Add Todo Screen'),
      ),
    );
  }
}
