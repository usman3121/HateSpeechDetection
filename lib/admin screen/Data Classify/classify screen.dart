import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ClassifyPage extends StatefulWidget {
  const ClassifyPage({Key? key}) : super(key: key);

  @override
  State<ClassifyPage> createState() => _ClassifyPageState();
}

class _ClassifyPageState extends State<ClassifyPage> {
  String? _inputText;
  String? _processedText;

  Future<void> _processText() async {
    if (_inputText != null) {
      // final apiUrl = 'http://10.0.2.2:8000/classify';
      final apiUrl = 'https://testproject-383709.el.r.appspot.com/classify'; //Replace with your API endpoint
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
                'Data Classifying',
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
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                ),
                onPressed: () {
                  _processText(); // Call the text processing function

                },
                child: const Text(
                  'Classifying',
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
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
