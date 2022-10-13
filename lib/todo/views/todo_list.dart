import 'package:firebase_todos/auth/auth_controller.dart';
import 'package:firebase_todos/components/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TodoListScreen extends StatelessWidget {
  static const routeName = '/';

  TodoListScreen({super.key});

  final AuthController authController = AuthController.to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(
        onLogoutPressed: () {
          Get.back();
          Get.defaultDialog(
            barrierDismissible: false,
            title: 'Logout'.toUpperCase(),
            middleText: 'Are you sure you want to logout?',
            cancel: TextButton(
              onPressed: () => Get.back(),
              child: const Text('Cancel'),
            ),
            confirm: TextButton(
              onPressed: () {
                Get.back();
                authController.handleSignOut();
              },
              style: TextButton.styleFrom(foregroundColor: Colors.redAccent),
              child: const Text('Confirm'),
            ),
          );
        },
      ),
      appBar: AppBar(
        title: const Text('My Todos'),
      ),
      body: const Center(
        child: Text('Todo List Screen'),
      ),
    );
  }
}
