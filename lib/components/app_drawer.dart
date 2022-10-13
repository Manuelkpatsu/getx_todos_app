import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_todos/auth/auth_controller.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  final void Function() onLogoutPressed;

  AppDrawer({super.key, required this.onLogoutPressed});

  final AuthController authController = AuthController.to;

  @override
  Widget build(BuildContext context) {
    User? user = authController.firebaseUser.value;

    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DrawerHeader(
            margin: EdgeInsets.zero,
            decoration: BoxDecoration(
              color: Colors.blueGrey[500],
            ),
            child: Column(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue.shade300,
                    image: DecorationImage(
                      image: user!.photoURL != null
                          ? NetworkImage(user.photoURL!)
                          : const AssetImage('assets/user.png')
                              as ImageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    user.email!,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
          const Divider(height: 0),
          ListTile(
            onTap: onLogoutPressed,
            title: const Text("Logout"),
            trailing: const Icon(Icons.exit_to_app),
          ),
          const Divider(height: 0),
        ],
      ),
    );
  }
}
