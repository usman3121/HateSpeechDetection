import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DelRec extends StatefulWidget {
  const DelRec({super.key});

  @override
  _DelRecState createState() => _DelRecState();
}

class _DelRecState extends State<DelRec> {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  List<UserModel> _userDetails = []; // Initialize with an empty list

  @override
  void initState() {
    super.initState();
    _fetchUserDetails();
  }

  Future<void> _fetchUserDetails() async {
    final snapshot = await _firebaseFirestore.collection("users").get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
    setState(() {
      _userDetails = userData;
    });
  }

  Future<void> _deleteUser(String userId) async {
    await _firebaseFirestore.collection("users").doc(userId).delete();
    await _fetchUserDetails(); // Fetch updated user details after deletion
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
      ),
      body: SingleChildScrollView(
        child: _userDetails.isNotEmpty // Check if the list is not empty
            ? ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: _userDetails.length,
          physics: const ClampingScrollPhysics(),
          reverse: true,
          itemBuilder: (context, index) {
            final user = _userDetails[index];
            return ListTile(
              iconColor: Colors.blue,
              tileColor: Colors.blue.withOpacity(0.1),
              leading: const Icon(Icons.info),
              title: Text("Email: ${user.email}"),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Username: ${user.name}"),
                  Text("Phone #: ${user.phone}"),
                  Text("Password: ${user.password}"),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => _deleteUser(user.id),
              ),
            );
          },
        )
            : const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String password;

  UserModel({
    required this.id,
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

  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
      id: document.id,
      name: data["Name"],
      email: data["Email"],
      phone: data["Phone"],
      password: data["Password"],
    );
  }
}
