import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'AdminDashboard.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({Key? key}) : super(key: key);

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();

  final String adminEmail = 'admin@gmail.com'; // Set the admin email here
  final String adminPassword = 'admin123'; // Set the admin password here

  // Perform admin authentication
  void signInAsAdmin(String password) {
    if (password == adminPassword) {
      // Grant access to the admin panel
      openAdminPanel();
    } else {
      // Deny access to the admin panel
      showAccessDeniedMessage();
    }
  }

  // Open the admin panel
  void openAdminPanel() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const dashboard()),
    );
  }

  // Show access denied message
  void showAccessDeniedMessage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Access Denied'),
          content: const Text('Invalid admin password.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Handle form submission
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      String password = _passwordController.text.trim();

      signInAsAdmin(password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 130),
              child: Image.network(
                'https://cdn-icons-png.flaticon.com/512/5190/5190582.png',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                color: Colors.deepPurple,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10, top: 50),
              child: Text(
                "ADMIN LOGIN",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      initialValue: adminEmail, // Set the initial value to admin email
                      enabled: false, // Disable editing of email field
                      decoration: const InputDecoration(
                        fillColor: Colors.amber,
                        labelText: "Username",
                        prefixIcon: Icon(Icons.people),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        labelText: "Password",
                        suffixIcon: Icon(Icons.remove_red_eye),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Password";
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            IconButton(
              iconSize: 50,
              icon: const Icon(Icons.login_rounded),
              onPressed: () {
                _submitForm();
              },
            ),
          ],
        ),
      ),
    );
  }
}
