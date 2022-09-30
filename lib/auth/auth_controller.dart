import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_todos/auth/views/login.dart';
import 'package:firebase_todos/components/loader.dart';
import 'package:firebase_todos/todo/views/todo_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'auth_service.dart';

class AuthController extends GetxController {
  static AuthController to = Get.find();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  Rxn<User> firebaseUser = Rxn<User>();

  @override
  void onReady() async {
    //run every time auth state changes
    ever(firebaseUser, handleAuthChanged);
    firebaseUser.bindStream(user);
    super.onReady();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  handleAuthChanged(User? authUser) {
    if (authUser == null) {
      Get.offAllNamed(LoginScreen.routeName);
    } else {
      Get.offAllNamed(TodoListScreen.routeName);
    }
  }

  Stream<User?> get user => _authService.onAuthChanged();

  Future<void> signInWithEmailAndPassword() async {
    showLoadingIndicator(modalColor: Colors.black.withOpacity(0.15));
    try {
      await _authService.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      emailController.clear();
      passwordController.clear();
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Sign In Error',
        e.message!,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
        backgroundColor: Get.theme.snackBarTheme.backgroundColor,
        colorText: Get.theme.snackBarTheme.actionTextColor,
      );
    } finally {
      hideLoadingIndicator();
    }
  }

  Future<void> registerWithEmailAndPassword() async {
    showLoadingIndicator(modalColor: Colors.black.withOpacity(0.15));
    try {
      await _authService.signUp(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      emailController.clear();
      passwordController.clear();
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Sign Up Failed.',
        e.message!,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
        backgroundColor: Get.theme.snackBarTheme.backgroundColor,
        colorText: Get.theme.snackBarTheme.actionTextColor,
      );
    } finally {
      hideLoadingIndicator();
    }
  }

  Future<void> googleSignIn() async {
    showLoadingIndicator(modalColor: Colors.black.withOpacity(0.15));
    try {
      GoogleSignInAccount? googleUser = await _authService.signInWithGoogle();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        await _authService.signInWithCredential(credential: credential);
      } else {
        return;
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Google Sign In Failed.',
        e.message!,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
        backgroundColor: Get.theme.snackBarTheme.backgroundColor,
        colorText: Get.theme.snackBarTheme.actionTextColor,
      );
    } finally {
      hideLoadingIndicator();
    }
  }

  Future<void> sendPasswordResetEmail() async {
    showLoadingIndicator(modalColor: Colors.black.withOpacity(0.15));
    try {
      await _authService.sendPasswordResetMail(email: emailController.text);
      emailController.clear();
      Get.snackbar(
        'Password Reset Email Sent',
        'Check your email and follow the instructions to reset your password.',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
        backgroundColor: Get.theme.snackBarTheme.backgroundColor,
        colorText: Get.theme.snackBarTheme.actionTextColor,
      );
    } on FirebaseAuthException catch (error) {
      Get.snackbar(
        'Password Reset Email Failed',
        error.message!,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
        backgroundColor: Get.theme.snackBarTheme.backgroundColor,
        colorText: Get.theme.snackBarTheme.actionTextColor,
      );
    } finally {
      hideLoadingIndicator();
    }
  }

  Future<void> handleSignOut() async {
    showLoadingIndicator(modalColor: Colors.black.withOpacity(0.15));
    try {
      await _authService.signOut();
    } on FirebaseAuthException catch (error) {
      Get.snackbar(
        'Logout Failed',
        error.message!,
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
