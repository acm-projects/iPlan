import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';

/// @author [MatthewSheldon]
/// The [UpdateFiles] class handles the updating of files in the Firebase/Firestore
/// cloud storage. To update a file in "events", use the [updateEventFile] method.
/// To update a file in "user id to user", use the [updateUserFile] method.
class UpdateFiles {
  /// Attempt to update the passed event document described by [documentID]
  /// with the passed [Map] object described by [json]. Returns false if the
  /// operation was successful, returns true otherwise.
  static Future<bool> updateEventFile(
      {required String documentID, required Map<String, dynamic> json}) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    try {
      FirebaseFirestore.instance.collection("events").doc(documentID).set(json);
    } catch (e) {
      print(e);
      return true; // Failed
    }
    return false; // Did not fail
  }

  /// Attempt to update the passed user document described by [documentID]
  /// with the passed [Map] object described by [json] Returns false if the
  /// operation was successful, returns true otherwise.
  static Future<bool> updateUserFile(
      {required String documentID, required Map<String, dynamic> json}) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    try {
      await FirebaseFirestore.instance
          .collection("user id to user")
          .doc(documentID)
          .update(json);
    } catch (e) {
      return true; // Failed
    }
    return false; // Did not fail
  }
}
