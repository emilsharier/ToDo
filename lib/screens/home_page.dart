import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String currentUser = "";

  @override
  void initState() {
    _getCurrentUser();
    super.initState();
  }

  _getCurrentUser() async {
    await FirebaseAuth.instance.currentUser().then((user) {
      setState(() {
        currentUser = user.email;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection("ToDo")
          .document(currentUser)
          .collection("items")
          .snapshots(),
      builder: (context, snapshots) {
        if (!snapshots.hasData) {
          return Center(
            child: Text("Uh oh! We can't find anything"),
          );
        } else {
          return ListView.builder(
              itemCount: snapshots.data.length,
              itemBuilder: (context, index) {
                return _buildList(context, snapshots.data.documents[index]);
              });
        }
      },
    );
  }

  _buildList(BuildContext context, DocumentSnapshot documentSnapshot) {
    return ListTile(
      title: Text(documentSnapshot['title']),
      subtitle: Expanded(
        child: Text(documentSnapshot['content']),
      ),
    );
  }
}
