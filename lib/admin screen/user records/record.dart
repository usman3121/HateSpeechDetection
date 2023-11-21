import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShowRecords extends StatelessWidget {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<List<UserModel>> getUserDetails() async {
    final snapshot = await _firebaseFirestore.collection("users").get();
    final userdata =
    snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
    return userdata;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
      ),
      body: FutureBuilder<List<UserModel>>(
        future: getUserDetails(),
        builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                physics: const ClampingScrollPhysics(),
                reverse: true,
                itemBuilder: (context, index) {
                  return ListTile(
                    iconColor: Colors.blue,
                    tileColor: Colors.blue.withOpacity(0.1),
                    leading: const Icon(Icons.info),
                    title: Text("Email: ${snapshot.data![index].email}"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Username: ${snapshot.data![index].name}"),
                        Text("Phone #: ${snapshot.data![index].phone}"),
                        Text("Password: ${snapshot.data![index].password}"),
                      ],
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              return const Center(
                child: Text("Something went wrong"),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

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

  toJson() {
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
      password: data["Password"],
    );
  }
}
