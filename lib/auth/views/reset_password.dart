import 'package:firebase_todos/auth/auth_controller.dart';
import 'package:firebase_todos/components/custom_button.dart';
import 'package:firebase_todos/components/custom_textfield.dart';
import 'package:firebase_todos/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ResetPasswordScreen extends StatelessWidget {
  static const routeName = '/reset_password';

  ResetPasswordScreen({super.key});

  final _key = GlobalKey<FormState>();
  final AuthController authController = AuthController.to;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: const CloseButton(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
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
                  'Forgot Password',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Please enter your email address to recover your password.',
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
                  inputAction: TextInputAction.done,
                ),
                const SizedBox(height: 20),
                CustomButton(
                  label: 'RECOVER PASSWORD',
                  color: Colors.black,
                  onPressed: () async {
                    if (_key.currentState!.validate()) {
                      SystemChannels.textInput.invokeMethod(
                        'TextInput.hide',
                      ); // to hide the keyboard - if any
                      await authController.sendPasswordResetEmail();
                    }
                  },
                  size: size,
                  textColor: Colors.white,
                  borderSide: BorderSide.none,
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
