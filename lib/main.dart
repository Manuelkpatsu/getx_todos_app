import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'auth/auth_controller.dart';
import 'components/loader.dart';
import 'routes.dart';
import 'splash_screen.dart';
import 'todo/todo_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put<AuthController>(AuthController());
  Get.put<TodoController>(TodoController());
  Get.testMode = true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Loading(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todo App with Get Package',
        navigatorKey: Get.key,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          appBarTheme: AppBarTheme(
            elevation: 0.0,
            backgroundColor: Colors.blueGrey[500],
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.light,
            ),
          ),
        ),
        initialRoute: SplashScreen.routeName,
        getPages: AppRoutes.routes,
      ),
    );
  }
}
