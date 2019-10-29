import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddToDo extends StatefulWidget {
  String name;

  AddToDo(this.name);
  @override
  _AddToDoState createState() => _AddToDoState();
}

class _AddToDoState extends State<AddToDo> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add ToDo"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _titleController,
            decoration: InputDecoration(
              hintText: 'Enter the title here',
            ),
          ),
          TextFormField(
            controller: _contentController,
            decoration: InputDecoration(
              hintText: 'Enter the Content here',
            ),
          ),
          RaisedButton(
            child: Text("Add"),
            onPressed: () {
              DateTime now = DateTime.now();
              String formattedTime =
                  DateFormat('kk:mm:ss EEE d MMM').format(now);
              Firestore.instance
                  .collection("todo")
                  .document(widget.name)
                  .collection("items")
                  .document(formattedTime)
                  .setData({
                'title': _titleController.text,
                'content': _contentController.text,
              });

              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
