import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'add_todo.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String currentUser = "null";

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
    return Scaffold(
      appBar: AppBar(
        title: Text(currentUser + "'s ToDo list"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddToDo(currentUser),
            ),
          );
        },
      ),
      body: StreamBuilder(
        stream: Firestore.instance
            .collection("todo")
            .document(currentUser)
            .collection("items")
            .getDocuments()
            .asStream(),
        builder: (context, snapshots) {
          if (!snapshots.hasData) {
            return Center(
              child: Text("Uh oh! We can't find anything"),
            );
          } else {
            QuerySnapshot doc = snapshots.data;
            List<DocumentSnapshot> docCount = doc.documents;
            return ListView.builder(
                itemCount: docCount.length,
                itemBuilder: (context, index) {
                  return _buildList(context, docCount[index]);
                });
          }
        },
      ),
    );
  }

  _buildList(BuildContext context, DocumentSnapshot documentSnapshot) {
    return ListTile(
      title: Text(documentSnapshot['title']),
      subtitle: Text(documentSnapshot['content']),
    );
  }
}
