import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';

/// @author [MatthewSheldon]
/// The [InviteUser] class handles the cloud computing side of inviting a 
/// collaborator. It creates a temporary document in "user id to user", 
/// retrieves its document ID, and then deletes the document. 
class InviteUser {
  /// Creates a temporary document and returns its document ID. This will
  /// serve as the temporary user ID for an invited collaborator.
  static Future<String> addCollaborator() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    String id = await FirebaseFirestore.instance.collection("user id to user").doc().id;
    return id;
  }
}
