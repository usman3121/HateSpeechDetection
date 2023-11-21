// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class DeleteAuthRecords extends StatefulWidget {
//   @override
//   _DeleteAuthRecordsState createState() => _DeleteAuthRecordsState();
// }
//
// class _DeleteAuthRecordsState extends State<DeleteAuthRecords> {
//   final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//   List<UserModel> _userDetails = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchUserDetails();
//   }
//
//   Future<void> _fetchUserDetails() async {
//     try {
//       final snapshot = await _firebaseFirestore.collection("users").get();
//       final userData =
//       snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
//       setState(() {
//         _userDetails = userData;
//       });
//     } catch (e) {
//       print("Error fetching user details: $e");
//     }
//   }
//
//   Future<void> _deleteUser(String userId) async {
//     try {
//       await _firebaseFirestore.collection("users").doc(userId).delete();
//       await _firebaseAuth.currentUser!.delete();
//       await _fetchUserDetails(); // Fetch updated user details after deletion
//     } catch (e) {
//       print("Error deleting user: $e");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Admin Dashboard'),
//       ),
//       body: SingleChildScrollView(
//         child: _userDetails.isNotEmpty
//             ? ListView.builder(
//           padding: EdgeInsets.zero,
//           shrinkWrap: true,
//           itemCount: _userDetails.length,
//           physics: ClampingScrollPhysics(),
//           reverse: true,
//           itemBuilder: (context, index) {
//             final user = _userDetails[index];
//             return ListTile(
//               iconColor: Colors.blue,
//               tileColor: Colors.blue.withOpacity(0.1),
//               leading: Icon(Icons.info),
//               title: Text("Email: ${user.email}"),
//               subtitle: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Text("Username: ${user.name}"),
//                   Text("Phone #: ${user.phone}"),
//                   Text("Password: ${user.password}"),
//                 ],
//               ),
//               trailing: IconButton(
//                 icon: Icon(Icons.delete),
//                 onPressed: () => _deleteUser(user.id),
//               ),
//             );
//           },
//         )
//             : Center(
//           child: CircularProgressIndicator(),
//         ),
//       ),
//     );
//   }
// }
//
// class UserModel {
//   final String id;
//   final String name;
//   final String email;
//   final String phone;
//   final String password;
//
//   UserModel({
//     required this.id,
//     required this.name,
//     required this.email,
//     required this.phone,
//     required this.password,
//   });
//
//   toJason() {
//     return {
//       "Name": name,
//       "Email": email,
//       "Phone": phone,
//       "Password": password,
//     };
//   }
//
//   factory UserModel.fromSnapshot(
//       DocumentSnapshot<Map<String, dynamic>> document) {
//     final data = document.data()!;
//     return UserModel(
//       id: document.id,
//       name: data["Name"],
//       email: data["Email"],
//       phone: data["Phone"],
//       password: data["Password"],
//     );
//   }
// }
