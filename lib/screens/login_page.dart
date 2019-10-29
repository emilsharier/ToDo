import 'package:flutter/material.dart';
import 'package:todo_firestore/critical_functions/auth_stream.dart';
import 'package:todo_firestore/screens/home_page.dart';

class LoginPage extends StatelessWidget {
  Model model = Model();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        child: Text("Login"),
        onPressed: () {
          model.signInWithGoogle().whenComplete(
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
