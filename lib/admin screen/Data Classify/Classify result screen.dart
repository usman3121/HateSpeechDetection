import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class clasifyresultTesting extends StatefulWidget {
  const clasifyresultTesting({Key? key}) : super(key: key);

  @override
  State<clasifyresultTesting> createState() => _clasifyresultTestingState();
}

class _clasifyresultTestingState extends State<clasifyresultTesting> {
  String? _inputText;
  String? _processedText;

  Future<void> _processText() async {
    if (_inputText != null) {
      // final apiUrl = 'http://10.0.2.2:8000/classify'; // Replace with your API endpoint
     // final apiUrl = 'http://usmantest-f5560ee3d809.herokuapp.com/classify';
      final apiUrl = 'https://testproject-383709.el.r.appspot.com/classify';

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
                'Data Classifyig',
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
                ),
                child: Table(
                  border: TableBorder.all(color: Colors.black),
                  children: [
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
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurple,
                ),
                onPressed: () {
                  _processText(); // Call the text processing function

                },
                child: const Text(
                  'lassifying',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: GestureDetector(
                onTap: _logout,
                child: const Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
