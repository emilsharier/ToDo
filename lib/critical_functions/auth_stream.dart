import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Model {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future signInWithGoogle() async {
    final GoogleSignInAccount _googleSignInAccount =
        await _googleSignIn.signIn();
    final GoogleSignInAuthentication _googleSignInAuthentication =
        await _googleSignInAccount.authentication;

    final AuthCredential _credentials = GoogleAuthProvider.getCredential(
      accessToken: _googleSignInAuthentication.accessToken,
      idToken: _googleSignInAuthentication.idToken,
    );

    final AuthResult _result = await _auth.signInWithCredential(_credentials);
    final FirebaseUser _user = _result.user;
    final FirebaseUser _currentUser = await _auth.currentUser();

    assert(!_user.isAnonymous);
    assert(await _user.getIdToken() != null);
    assert(_user.uid == _currentUser.uid);

    print("Logged in as " + _currentUser.email);
    // return _currentUser.email;
  }

  Future signOut() async {
    await _googleSignIn.signOut();
  }

}
