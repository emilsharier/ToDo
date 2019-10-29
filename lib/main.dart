import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_firestore/critical_functions/auth_stream.dart';
import 'package:todo_firestore/screens/login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoading;
  Model model = Model();

  @override
  void initState() {
    _isLoading = true;

    FirebaseAuth.instance.currentUser().then((user) {
      if (user != null) {
        _isLoading = false;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("ToDo"),
        ),
        body: (_isLoading == true) ? _displayLoadingIndicator() : LoginPage(),
      ),
    );
  }

  _displayLoadingIndicator() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        Text("Checking for user login!"),
      ],
    );
  }
}
