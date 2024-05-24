import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:week1/models/notes.dart';

import '../firebase_options.dart';

class FirebaseHelper {
  final FirebaseFirestore _instance = FirebaseFirestore.instance;

  final String collectionName = "notes";
  final String collectionCounter = "Counter";
  FirebaseHelper._privateConstructor();

  static final FirebaseHelper _firebaseHelper =
      FirebaseHelper._privateConstructor();
  static bool _isFirstTime = true;


  static Future<FirebaseHelper> getInstance() async {
    if (_isFirstTime) {
      await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform);

      _isFirstTime = false;
    }
    return _firebaseHelper;
  }

  Future<int> existingCounter() async {
    var docRef = _instance.collection(collectionCounter).doc("counter");

    var docSnapshot = await docRef.get();

    if (docSnapshot.exists) {
      return docSnapshot.data()?['value'] ?? 1;
    }

    await docRef.set({"value": 1});
    return 1;
  }

  // Future addnote(Note note) async {
  //   await _instance
  //       .collection(collectionName)
  //       .doc(note.id)
  //       .set(note.toJsonMap());

  //   int counter = await _firebaseHelper.existingCounter();

  //   await _instance
  //       .collection(collectionCounter)
  //       .doc("counter")
  //       .set({"value": counter + 1});
  // }

  // Future deletenote(String key) async {
  //   await _instance.collection(collectionName).doc(key).delete();
  // }

  // Future<List<Note>> getAllData() async {
  //   List<Note> allnotesData = [];

  //   var collectionSnapshot = await _instance.collection(collectionName).get();

  //   for (var doc in collectionSnapshot.docs) {
  //     allnotesData.add(Note.fromJsonMap(doc.data()));
  //   }
  //   return allnotesData;
  // }

}
