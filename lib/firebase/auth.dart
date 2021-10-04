import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

Future<UserCredential> registerNewUser(String email, String password) async {
  var user = await FirebaseAuth.instance
      .createUserWithEmailAndPassword(email: email, password: password);
  return user;
}

Future<UserCredential> signInMail(String email, String password) async {
  var user = await FirebaseAuth.instance
      .signInWithEmailAndPassword(email: email, password: password);
  return user;
}
