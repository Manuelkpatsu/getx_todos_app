import 'package:firebase_todos/auth/auth_controller.dart';
import 'package:firebase_todos/todo/models/todo.dart';
import 'package:firebase_todos/todo/todo_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/loader.dart';

class TodoController extends GetxController {
  static TodoController to = Get.find();
  RxList<Todo> todos = <Todo>[].obs;
  var todo = Todo(userId: '', title: '', id: '').obs;
  final TodoService _todoService = TodoService();
  final AuthController _authController = AuthController.to;

  @override
  void onInit() {
    /// here we tell todos to stream from the load todos method
    /// if authenticated user is not null.
    if (_authController.firebaseUser.value != null) {
      todos.bindStream(loadTodos());
    }
    super.onInit();
  }

  Stream<List<Todo>> loadTodos() {
    return _todoService.findAll(
      userId: _authController.firebaseUser.value!.uid,
    );
  }

  Future<void> getTodo({required String id}) async {
    showLoadingIndicator(modalColor: Colors.black.withOpacity(0.15));
    try {
      final snapshot = await _todoService.findOne(id: id);
      todo.value = Todo(
        userId: snapshot.data()!.userId,
        title: snapshot.data()!.userId,
        done: snapshot.data()!.done,
        id: snapshot.id,
      );
    } catch (e) {
      Get.snackbar(
        'Sign In Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
        backgroundColor: Get.theme.snackBarTheme.backgroundColor,
        colorText: Get.theme.snackBarTheme.actionTextColor,
      );
    } finally {
      hideLoadingIndicator();
    }
  }

  Future<void> addTodo({required String title}) async {
    showLoadingIndicator(modalColor: Colors.black.withOpacity(0.15));
    try {
      final todo = Todo(
        userId: _authController.firebaseUser.value!.uid,
        title: title,
      );
      await _todoService.addOne(todo: todo);
      Get.back();
      Get.snackbar(
        "Success",
        "Todo added successfully",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.snackBarTheme.backgroundColor,
        colorText: Get.theme.snackBarTheme.actionTextColor,
      );
    } catch (e) {
      Get.snackbar(
        'Adding New Update Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
        backgroundColor: Get.theme.snackBarTheme.backgroundColor,
        colorText: Get.theme.snackBarTheme.actionTextColor,
      );
    } finally {
      hideLoadingIndicator();
    }
  }

  Future<void> updateTodo({required Todo todo}) async {
    showLoadingIndicator(modalColor: Colors.black.withOpacity(0.15));
    try {
      await _todoService.updateOne(todo: todo);
      Get.back();
      Get.snackbar(
        "Success",
        "Todo updated successfully",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.snackBarTheme.backgroundColor,
        colorText: Get.theme.snackBarTheme.actionTextColor,
      );
    } catch (e) {
      Get.snackbar(
        'Update Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
        backgroundColor: Get.theme.snackBarTheme.backgroundColor,
        colorText: Get.theme.snackBarTheme.actionTextColor,
      );
    } finally {
      hideLoadingIndicator();
    }
  }

  Future<void> deleteTodo({required Todo todo}) async {
    try {
      await _todoService.deleteOne(todo: todo);
      int index = todos.indexWhere((e) => e.id == todo.id);
      todos.removeAt(index);
      Get.snackbar(
        "Success",
        "Todo deleted successfully",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.snackBarTheme.backgroundColor,
        colorText: Get.theme.snackBarTheme.actionTextColor,
      );
    } catch (e) {
      Get.snackbar(
        'Deletion Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
        backgroundColor: Get.theme.snackBarTheme.backgroundColor,
        colorText: Get.theme.snackBarTheme.actionTextColor,
      );
    } finally {
      hideLoadingIndicator();
    }
  }
}
