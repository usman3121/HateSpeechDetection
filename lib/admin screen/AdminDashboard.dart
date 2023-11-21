import 'package:flutter/material.dart';
import 'package:hate_speech/admin%20screen/user%20records/record.dart';
import '../User Screen/starter_screen.dart';
import 'Data Classify/classify screen.dart';
import 'Delete Users/del.dart';
import 'button.dart';

class dashboard extends StatefulWidget {
  const dashboard({Key? key}) : super(key: key);

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  // Function to handle the logout button pressed
  void logout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const frstScreen()),
          (route) => false, // Remove all existing routes from the stack
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 130, left: 30),
            child: Text(
              "Welcome Admin",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 60,
              left: 40,
            ),
            child: Column(
              children: [
                UsmanButton(
                  label: "Classify The Data",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ClassifyPage()),
                    );
                  },
                ),
                const SizedBox(
                  height: 50,
                ),
                UsmanButton(
                  label: "User Records",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  ShowRecords()),
                    );
                  },
                ),
                const SizedBox(
                  height: 50,
                ),
                UsmanButton(
                  label: "Delete Users",
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>   DelRec()));
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 60),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
              ),
              onPressed: logout, // Call the logout function when pressed
              child: const Text(
                'LOGOUT',
                style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
