import 'package:flutter/material.dart';
import 'package:hate_speech/User%20Screen/starter_screen.dart';
import 'package:http/http.dart' as http;
 // import the sign-in page file

class Userclassify extends StatefulWidget {
  const Userclassify({Key? key}) : super(key: key);

  @override
  State<Userclassify> createState() => _UserclassifyState();
}

class _UserclassifyState extends State<Userclassify> {
  String? _inputText;
  String? _processedText;

  Future<void> _processText() async {
    if (_inputText != null) {
      //final apiUrl = 'http://usmantest-f5560ee3d809.herokuapp.com/classify'; // Replace with your API endpoint
      final apiUrl = 'https://testproject-383709.el.r.appspot.com/classify'; // Replace with your API endpoint
      final response = await http.post(Uri.parse(apiUrl), body: {'text': _inputText!});

      if (response.statusCode == 200) {
        setState(() {
          _processedText = response.body;
        });
      } else {
        // Handle error
      }
    }
  }

  void _logout() {
    // Implement logout functionality here
    // Example: Clear user data, navigate to login screen, etc.
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => frstScreen()), // Replace SignInPage() with your actual sign-in page widget
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Hate Speech And Terrorism Detection",
          style: TextStyle(
            color: Colors.deepPurple,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.deepPurple),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(86),
              child: Text(
                'Data Classifing',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  // border: Border.all(color: Colors.black),
                ),
                child: Table(
                  border: TableBorder.all(color: Colors.black),
                  children: [
                    const TableRow(
                      children: [
                        TableCell(
                          child: Text(
                            'POSTS',
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        TableCell(
                          child: Text(
                            'RESULTS',
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  _inputText = value;
                                });
                              },
                              decoration: const InputDecoration(
                                hintText: 'Enter your text',
                              ),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              _processedText ?? '',
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepPurple,
                    ),
                    onPressed: _processText,
                    child: const Text(
                      'Classifyin',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepPurple,
                    ),
                    onPressed: _logout,
                    child: const Text(
                      'Logout',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
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
