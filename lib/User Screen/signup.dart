/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hate_speech/utils/utils.dart';
import 'login.dart';
import 'starter_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class User {
  final String email;
  final String phoneNumber;

  User({required this.email, required this.phoneNumber});
}

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formkey = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final _phoneNumberController = TextEditingController();

  Future SignUp() async {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: emailcontroller.text.toString(),
            password: emailcontroller.text.toString())
        .then((value) {})
        .onError((error, stackTrace) {
      Utils().toastMessage(error.toString());
    });
  }

  void signUp() {
    String email = emailcontroller.text.trim();
    String phoneNumber = _phoneNumberController.text.trim();

    // Save user data to Firebase Firestore
    FirebaseFirestore.instance
        .collection('users')
        .add({'email': email, 'phoneNumber': phoneNumber}).then((value) {
      // Handle successful signup
      print('User signed up successfully!');
    }).catchError((error) {
      // Handle signup error
      print('An error occurred during signup: $error');
    });
  }

  @override
  void dispose() {
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
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
              padding: EdgeInsets.only(left: 30, top: 50),
              child: Text(
                "SIGNUP",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Form(
                key: _formkey,
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailcontroller,
                          decoration: const InputDecoration(
                            fillColor: Colors.amber,
                            labelText: "email",
                            prefixIcon:
                                Icon(Icons.people), //icon at head of input
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Email";
                            }
                            return null;
                          },
                        )),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          controller: passwordcontroller,
                          obscureText: true,
                          // controller: password,
                          decoration: const InputDecoration(
                              //icon at head of input
                              prefixIcon: Icon(Icons
                                  .lock), //you can use prefixIcon property too.
                              labelText: "Password",
                              suffixIcon: Icon(
                                  Icons.remove_red_eye) //icon at tail of input
                              ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Password";
                            }
                            return null;
                          },
                        )),
                  ],
                )),

            */
/* const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: TextField(
                // controller: username,
                  decoration: InputDecoration(fillColor: Colors.amber,
                    labelText: "Username",
                    prefixIcon: Icon(Icons.people), //icon at head of input
                  )),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: TextField(
                // controller: username,
                  decoration: InputDecoration(fillColor: Colors.amber,
                    labelText: "Phone #",
                    prefixIcon: Icon(Icons.phone), //icon at head of input
                  )),
            ),*//*

            const SizedBox(
              height: 15,
            ),
            IconButton(
                iconSize: 50,
                icon: const Icon(
                  Icons.login_rounded,
                ),
                onPressed: () {
                  SignUp();
                }),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account?",
                    style: TextStyle(fontSize: 20)),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const login()),
                      );
                    },
                    child: const Text("SignIn",
                        style:
                            TextStyle(fontSize: 30, color: Colors.blueAccent))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
*/
