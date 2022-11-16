import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:practice_test/Backend/Authentication/update_files.dart';
import '../User_Creation/user.dart' as backend;

class Settings {
  /// Code returned when [validatePassword], [changePassword],
  /// [changeEmail], or [changeUserName] encountered no errors
  static const int success = 0;

  /// Code returned when [validatePassword] failed to validate the password passed to it
  static const int validateFailed = 1;

  /// Code returned when [changePassword] failed to change the user's password
  /// on Firebase's side of things
  static const int firebaseUpdatePasswordFailed = 2;

  /// Code returned when [changeEmail] failed to change the user's email
  /// on Firebase's side of things
  static const int firebaseUpdateEmailFailed = 3;

  /// Code returned when [changeEmail] failed to change the user's email
  /// on the Backend's side of things
  static const int backendUpdateEmailFailed = 4;

  /// Code returned when [changeUserName] failed to change the user's username
  /// on Firebase's side of things
  static const int firebaseUpdateUserNameFailed = 5;

  /// Code returned when [changeUserName] failed to change the user's username
  /// on the backend's side of things
  static const int backendUpdateUserNameFailed = 6;

  /// Attempt to validate the user's current password for the account described
  /// by the passed [email] with the password [password]. If the operation is
  /// successful, both [success] and [backend.User] objects will be returned. 
  /// Otherwise, [validateFailed] will be the only thing returned.
  static Future<List<dynamic>> validatePassword(
      {required String email, required String password}) async {
    List<dynamic> ans = <dynamic>[];
    firebase.User? currentUser = firebase.FirebaseAuth.instance.currentUser;
    firebase.UserCredential credential;
    // Attempt to validate the user's current password
    try {
      credential = await currentUser!.reauthenticateWithCredential(
          firebase.EmailAuthProvider.credential(
              email: email, password: password));
    } catch (e) {
      // Password confirmatoin failed
      print(e);
      ans.add(validateFailed);
      return ans;
    }
    // Password confirmation successful
    ans.add(success);
    ans.add(currentUser);
    return ans;
  }

  /// Attempt to change the user's password in the cloud for the account 
  /// described by the passed [firebase.User] object and update it to
  /// the passed [newPassword]. If the operation is successful, both [success]
  /// and the updated [firebase.User] object will be returned. Otherwise, 
  /// [firebaseUpdatePasswordFailed] will be returned.
  static Future<List<dynamic>> changePassword(
      {required firebase.User firebaseUser,
      required String newPassword}) async {
    List<dynamic> ans = <dynamic>[];
    // Attempt to update the user's password in Firebase
    try {
      await firebaseUser.updatePassword(newPassword);
    } catch (e) {
      // Password update failed
      print(e);
      ans.add(firebaseUpdatePasswordFailed);
      return ans;
    }
    // Password update successful
    ans.add(success);
    ans.add(firebaseUser);
    return ans;
  }

  /// Attempt to change the user's email in both the cloud and the backend
  /// described by the passed [firebase.User] object and the psased [backend.User]
  /// object with the new email described by the passed [newEmail]. If the email 
  /// failed to be changed in the cloud, only [firebaseUpdateEmailFailed] will 
  /// be returned. If the operation is successful, [success], the updated 
  /// [backend.User], and updated [firebase.User] objects will be returned. 
  /// Otherwise, [backendUpdateEmailFailed] will be returned instead of [success].
  static Future<List<dynamic>> changeEmail(
      {required firebase.User firebaseUser,
      required backend.User backendUser,
      required String newEmail}) async {
    List<dynamic> ans = <dynamic>[];
    // Attempt to update the user's email on Firebase's side of things
    try {
      await firebaseUser.updateEmail(newEmail);
    } catch (e) {
      // Email update failed
      print(e);
      ans.add(firebaseUpdateEmailFailed);
      return ans;
    }
    // Email update successful

    // Attempt to update the user's email on the backend side of things
    backendUser.updateEmail(newEmail: newEmail);
    bool failed = await UpdateFiles.updateUserFile(
        documentID: backendUser.getUserID(), json: backendUser.toJson());
    // Add the appropriate code
    ans.add(failed ? backendUpdateEmailFailed : success);
    ans.add(backendUser);
    ans.add(firebaseUser);
    return ans;
  }

  /// Attempts to change the user's username described by the [firebase.User]
  /// and [backend.User] objects, to the passed [newUserName] parameter. If
  /// the username failed to be updated in the cloud, return the code
  /// [firebaseUpdateUserNameFailed]. If the operation was successful, return
  /// the code [success] as well as the updated [firebase.User] and [backend.User]
  /// objects. Otherwise, return [backendUpdateUserNameFailed] instead of [success].
  static Future<List<dynamic>> changeUserName(
      {required firebase.User firebaseUser,
      required backend.User backendUser,
      required String newUserName}) async {
    List<dynamic> ans = <dynamic>[];
    // Attempt to update the user's username in the cloud
    try {
      await firebaseUser.updateDisplayName(newUserName);
    } catch (e) {
      // Username update failed
      print(e);
      ans.add(firebaseUpdateUserNameFailed);
      return ans;
    }
    // Username update success

    // Attempt to update the user's username in the backend
    backendUser.updateUserName(newName: newUserName);
    bool failed = await UpdateFiles.updateUserFile(
        documentID: backendUser.getUserID(), json: backendUser.toJson());
    // Add the appropriate code
    ans.add(failed ? backendUpdateUserNameFailed : success);
    ans.add(firebaseUser);
    ans.add(backendUser);
    return ans;
  }
}