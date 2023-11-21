// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// class deletefromDatabase extends StatelessWidget {
//   final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
//   late DocumentReference _documentReference;
//   late Future<DocumentSnapshot> _futureDocument;
//
//
//   Future<List<UserModel>> getUserDetails() async {
//     final snapshot = await _firebaseFirestore.collection("users").get();
//     final userdata =
//         snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
//     return userdata;
//   }
//
//   Future<void> deleteUser(String userId) async {
//     await _firebaseFirestore.collection("users").doc(id).delete();
//   }
//   Future<void> deleteUse(String userId) async {
//     _documentReference= FirebaseFirestore.instance.collection("users").doc(userId);
//     _futureDocument=_documentReference.get();
//
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Admin Dashboard'),
//       ),
//       body: SingleChildScrollView(
//         child: FutureBuilder<List<UserModel>>(
//           future: getUserDetails(),
//           builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
//             if (snapshot.connectionState == ConnectionState.done) {
//               if (snapshot.hasData) {
//                 return ListView.builder(
//                   padding: EdgeInsets.zero,
//                   shrinkWrap: true,
//                   itemCount: snapshot.data!.length,
//                   physics: const ClampingScrollPhysics(),
//                   reverse: true,
//                   itemBuilder: (c, index) {
//                     final user = snapshot.data![index];
//
//                     return ListTile(
//                       iconColor: Colors.blue,
//                       tileColor: Colors.blue.withOpacity(0.1),
//                       leading: const Icon(Icons.info),
//                       title: Text("Email: ${user.email}"),
//                       subtitle: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Text("Username : ${user.name}"),
//                           Text("Phone# : ${user.phone}"),
//                           Text("Password : ${user.password}"),
//                         ],
//                       ),
//                       trailing: IconButton(
//                         icon: const Icon(Icons.delete),
//                         color: Colors.red, // Set the icon color to white
//                         onPressed: () => _documentReference.delete()
//                       ),
//                     );
//                   },
//                 );
//               } else if (snapshot.hasError) {
//                 return Center(
//                   child: Text(snapshot.error.toString()),
//                 );
//               } else {
//                 return const Center(
//                   child: Text("Something went wrong"),
//                 );
//               }
//             } else {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//           },
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
