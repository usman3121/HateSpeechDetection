import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../utils/utils.dart';
import 'login.dart';

class UserModel {
  final String name;
  final String email;
  final String phone;
  final String password;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
  });

  toJason() {
    return {
      "Name": name,
      "Email": email,
      "Phone": phone,
      "Password": password,
    };
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
        name: data["Name"],
        email: data["Email"],
        phone: data["Phone"],
        password: data["Password"]);
  }
}

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  final _formkey = GlobalKey<FormState>();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController userNameController = TextEditingController();

  Future<void> SignUp() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailcontroller.text.toString(),
        password: passwordcontroller.text.toString(),
      );
      final user = UserModel(
        name: userNameController.text,
        email: emailcontroller.text,
        phone: phoneNumberController.text,
        password: passwordcontroller.text,
      );
      await createUser(user);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Signup Successful'),
            content: const Text('You have been successfully registered.'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } catch (error) {
      Utils().toastMessage(error.toString());
    }
  }



  Future<void> createUser(UserModel user) async {
    await _db.collection("users").add(user.toJason());
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
                            if (value.length < 6) {
                              return "Password must be at least 6 characters";
                            }
                            return null;
                          },
                        )),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextField(
                  controller: userNameController,
                  decoration: const InputDecoration(
                    fillColor: Colors.amber,
                    labelText: "Username",
                    prefixIcon: Icon(Icons.people), //icon at head of input
                  )),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: TextField(
                  controller: phoneNumberController,
                  decoration: const InputDecoration(
                    fillColor: Colors.amber,
                    labelText: "Phone #",
                    prefixIcon: Icon(Icons.phone), //icon at head of input
                  )),
            ),
            const SizedBox(
              height: 15,
            ),
            IconButton(
                iconSize: 50,
                icon: const Icon(
                  Icons.login_rounded,
                ),
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    SignUp().then((value) {
                      final user = UserModel(
                          name: userNameController.text,
                          email: emailcontroller.text,
                          phone: phoneNumberController.text,
                          password: passwordcontroller.text);
                      createUser(user);
                    });
                  }
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
