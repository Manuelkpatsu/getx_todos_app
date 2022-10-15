import 'package:firebase_todos/auth/auth_controller.dart';
import 'package:firebase_todos/auth/views/register.dart';
import 'package:firebase_todos/components/custom_button.dart';
import 'package:firebase_todos/components/custom_textfield.dart';
import 'package:firebase_todos/components/label_button.dart';
import 'package:firebase_todos/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'reset_password.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';

  LoginScreen({super.key});

  final _key = GlobalKey<FormState>();
  final AuthController authController = AuthController.to;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _key,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Sign into your Account',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Log into your account',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  'Email address',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  hintText: 'abc@example.com',
                  keyboardType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.none,
                  validator: (value) => Validator.validateEmail(value),
                  controller: authController.emailController,
                  inputAction: TextInputAction.next,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Password',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  hintText: '********',
                  obscureText: true,
                  controller: authController.passwordController,
                  textCapitalization: TextCapitalization.none,
                  validator: (value) => Validator.validatePassword(value),
                  inputAction: TextInputAction.done,
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: LabelButton(
                    labelText: 'Forgot password?',
                    onPressed: () => Get.toNamed(ResetPasswordScreen.routeName),
                  ),
                ),
                const SizedBox(height: 10),
                CustomButton(
                  label: 'LOGIN',
                  color: Colors.black,
                  onPressed: () async {
                    if (_key.currentState!.validate()) {
                      SystemChannels.textInput.invokeMethod(
                        'TextInput.hide',
                      ); // to hide the keyboard - if any
                      await authController.signInWithEmailAndPassword();
                    }
                  },
                  size: size,
                  textColor: Colors.white,
                  borderSide: BorderSide.none,
                ),
                const SizedBox(height: 20),
                CustomButton(
                  label: 'GOOGLE SIGN IN',
                  color: Colors.red,
                  onPressed: () async {
                    await authController.googleSignIn();
                  },
                  size: size,
                  textColor: Colors.white,
                  borderSide: BorderSide.none,
                ),
                const SizedBox(height: 10),
                LabelButton(
                  labelText: 'Create an Account',
                  onPressed: () => Get.toNamed(RegisterScreen.routeName),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
