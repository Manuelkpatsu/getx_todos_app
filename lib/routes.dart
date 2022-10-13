import 'package:get/get.dart';

import 'auth/views/login.dart';
import 'auth/views/register.dart';
import 'auth/views/reset_password.dart';
import 'splash_screen.dart';
import 'todo/views/add_todo.dart';
import 'todo/views/edit_todo.dart';
import 'todo/views/todo_list.dart';

class AppRoutes {
  AppRoutes._();

  static final routes = [
    GetPage(name: SplashScreen.routeName, page: () => const SplashScreen()),
    GetPage(name: TodoListScreen.routeName, page: () => TodoListScreen()),
    GetPage(name: LoginScreen.routeName, page: () => LoginScreen()),
    GetPage(name: RegisterScreen.routeName, page: () => RegisterScreen()),
    GetPage(name: EditTodoScreen.routeName, page: () => const EditTodoScreen()),
    GetPage(name: AddTodoScreen.routeName, page: () => const AddTodoScreen()),
    GetPage(
      name: ResetPasswordScreen.routeName,
      page: () => ResetPasswordScreen(),
    ),
  ];
}
