import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grad/models/user.dart';

class FirebaseHelper {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<void> saveUserData(MyUser user) async {
    //* Convert user data to a Map
    Map<String, dynamic> userData = {
      'firstName': user.firstName,
      'lastName': user.lastName,
      'email': user.email,
      'phone': user.phone,
      'userId': user.userId
    };

    //* Add user data to Firestore collection
    firebaseFirestore.collection('users').doc(user.userId).set(userData);
    log('User data saved successfully');
  }
}
