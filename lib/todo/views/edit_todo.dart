import 'package:flutter/material.dart';

class EditTodoScreen extends StatelessWidget {
  static const routeName = '/todos/:id/edit';

  const EditTodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Edit Todo Screen'),
      ),
    );
  }
}
