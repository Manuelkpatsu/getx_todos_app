import 'package:firebase_todos/auth/auth_controller.dart';
import 'package:firebase_todos/auth/views/login.dart';
import 'package:firebase_todos/components/custom_button.dart';
import 'package:firebase_todos/components/custom_textfield.dart';
import 'package:firebase_todos/components/label_button.dart';
import 'package:firebase_todos/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  static const routeName = '/register';

  RegisterScreen({super.key});

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
                  'Create Account',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Open an account with a few details.',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 40),
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
                  hintText: '******',
                  obscureText: true,
                  textCapitalization: TextCapitalization.none,
                  controller: authController.passwordController,
                  validator: (value) => Validator.validatePassword(value),
                  inputAction: TextInputAction.done,
                ),
                const SizedBox(height: 20),
                CustomButton(
                  label: 'CREATE YOUR ACCOUNT',
                  color: Colors.black,
                  onPressed: () async {
                    if (_key.currentState!.validate()) {
                      SystemChannels.textInput.invokeMethod(
                        'TextInput.hide',
                      ); // to hide the keyboard - if any
                      await authController.registerWithEmailAndPassword();
                    }
                  },
                  size: size,
                  textColor: Colors.white,
                  borderSide: BorderSide.none,
                ),
                const SizedBox(height: 20),
                LabelButton(
                  labelText: 'Have an Account? Sign In.',
                  onPressed: () => Get.toNamed(LoginScreen.routeName),
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
