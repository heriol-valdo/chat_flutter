

import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:firebase_admin/firebase_admin.dart';
import 'package:flutter/material.dart';



import 'package:fluttertoast/fluttertoast.dart';

import '../../chat/Database_services/notification_service.dart';
import '../../chat/models/user.dart';
import '../Database_services/database.dart';


 class AuthenticationService{

   final FirebaseAuth _auth = FirebaseAuth.instance;


  AppUser? _userFromFirebaseUser(User? user) {
    initUser(user);
    return user != null ? AppUser(user.uid) : null;
  }

  void initUser(User? user) async {
    if (user == null) return;
    NotificationService.getToken().then((value) {

    });
  }


  Stream<AppUser?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }


  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result =
          await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (exception) {
      print(exception.toString());
      // ignore: deprecated_member_use
      return null;
    }
  }



  Future registerWithEmailAndPassword(String name,String sexe, String email, String password) async {
    try {
      UserCredential result =
          await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      if (user == null) {
        throw Exception("No user found");
      } else {

        await DatabaseService(user.uid).saveUser(name,email,"","","","","","","",sexe);
        return _userFromFirebaseUser(user);
      }
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }


 }






