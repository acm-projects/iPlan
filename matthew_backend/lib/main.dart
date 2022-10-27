import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:matthew_backend/Backend/Authentication/log_in_authentication.dart';

import 'Backend/Event_Manager/event.dart';
import 'Backend/Event_Manager/event_creator.dart';
import 'Backend/User_Creation/user_creator.dart';
import 'Backend/User_Creation/user_assembler.dart';
import 'Backend/User_Creation/user.dart';

void main() async {
  // Test the ability to log into an account
  String? matthewUserID = await LogInAuthentication.logInWithEmail(email: "Matthew.Sheldon@utdallas.edu", password: "iPlanIsTheBest");

  // Test the ability to add new a new user to the system
  List<dynamic> ans = await UserCreator.createNewUser(
      email: "jon.perry@gmail.com",
      password: "absolute_legend",
      name: "Jon Perry");
  String jonUserID = ans[1];
  print(
      "\nCode returned from adding a new user: ${ans[0]}\n"); // This should be 0
  print("\nUser ID associated with the above result: ${ans[1]}\n");

  // Test the ability to detect a user who already has the requested email
  ans = await UserCreator.createNewUser(
      email: "Matthew.Sheldon@utdallas.edu",
      password: "iPlanIsTheBest",
      name: "Matthew Sheldon");
  print(
      "\nCode returned from attempting to create a new user with an email that is taken: ${ans[0]}\n"); // This should be 1

  // Attempt to uplaod an entire event to the cloud
  // String jsonData =
  //     "{ \"financePage\": {}, \"calendarPage\": {}, \"itineraryPage\": {}, \"collaborationPage\": { \"title\": \"Event Name\", \"date\": \"April 25, 2022\", \"collaborators\": [ { \"name\": \"Matthew Sheldon\", \"email\": \"Matthew.Sheldon@utdallas.edu\", \"phoneNumber\": \"\", \"hasAccepted\": true }, { \"name\": \"Veda Charthad\", \"email\": \"\", \"phoneNumber\": \"(346) 970-8296\", \"hasAccepted\": true }, { \"name\": \"Casi Marquez\", \"email\": \"\", \"phoneNumber\": \"+1 (972) 370-4236\", \"hasAccepted\": false } ] } }";
  // Map<String, dynamic> json = jsonDecode(jsonData);
  // Event e = Event.fromJson(json: json, link: "ggaVFh6jrUqhVLlDl38w");
  // FirebaseFirestore.instance
  //     .collection("events")
  //     .doc("ggaVFh6jrUqhVLlDl38w")
  //     .set(e.toJson());
  // Check Firestore for the results (unless an exception occurred)

  // Creating multiple users that are new
  ans = await UserCreator.createNewUser(
      email: "Casandra.Marquez@utdallas.edu",
      password: "where_are_my_children",
      name: "Casi Marquez");
  String casiUserID = ans[1];

  ans = await UserCreator.createNewUser(
      email: "Veda.Charthad@utdallas.edu",
      password: "thats_my_project_manager",
      name: "Veda Charthad");
  String vedaUserID = ans[1];

  ans = await UserCreator.createNewUser(
      email: "Jennifer.Zhang2@utdallas.edu",
      password: "insane_typing_speed",
      name: "Jennifer Zhang");
  String jenniferUserID = ans[1];

  ans = await UserCreator.createNewUser(
      email: "Sharun.Naicker@utdallas.edu",
      password: "mac_is_better_ig",
      name: "Sharun Naicker");
  String sharunUserID = ans[1];

  // Attempt to create User objects for all of the user IDs
  UserAssembler userAssembler = UserAssembler(userID: jonUserID);
  ans = await userAssembler.assembleUserFromCloud();
  User jon = ans[1];
  print("Jon's User ID from User object: ${jon.getUserID()}\n");

  userAssembler = UserAssembler(userID: casiUserID);
  ans = await userAssembler.assembleUserFromCloud();
  User casi = ans[1];
  print("Casi's user name from User object: ${casi.getUserName()}\n");

  userAssembler = UserAssembler(userID: vedaUserID);
  ans = await userAssembler.assembleUserFromCloud();
  User veda = ans[1];
  print("Veda's email from User object: ${veda.getEmail()}\n");

  userAssembler = UserAssembler(userID: jenniferUserID);
  ans = await userAssembler.assembleUserFromCloud();
  User jennifer = ans[1];
  print(
      "Jennifer's list of event IDs from User object: ${jennifer.getEventIDs()}\n");

  userAssembler = UserAssembler(userID: sharunUserID);
  ans = await userAssembler.assembleUserFromCloud();
  User sharun = ans[1];
  print("Sharun's list of events from User object: ${sharun.getEvents()}\n");

  // Testing the ability to add events to a user's account and to update all necessary files
  EventCreator.joinEventFromLink(user: jon, link: "ggaVFh6jrUqhVLlDl38w");
}
