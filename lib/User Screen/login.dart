import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../utils/utils.dart';
import 'SignUpData.dart';
import 'classification screen.dart';


class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final _formkey = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  Future<void> Login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailcontroller.text.toString(),
        password: passwordcontroller.text.toString(),
      );
      // User signed in successfully
      String currentUser = FirebaseAuth.instance.currentUser!.email!;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Login Successful'),
            content: Text('Welcome to $currentUser'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // Navigate to the desired screen after closing the dialog
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Userclassify()),
                  );
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (error) {
      Utils().toastMessage(error.toString());
    }
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
                "LOGIN",
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
                            labelText: "Username",
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
                    Login();
                  }
                }),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("You don't have an account?",
                    style: TextStyle(fontSize: 20)),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignUp()),
                      );
                    },
                    child: const Text("SignUp",
                        style:
                            TextStyle(fontSize: 30, color: Colors.blueAccent))),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: const [
                  Expanded(
                    child: Divider(
                      color: Colors.black,
                      thickness: 1,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'or',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.black,
                      thickness: 1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
