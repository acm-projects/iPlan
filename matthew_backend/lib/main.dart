import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:matthew_backend/Backend/Event_Manager/event.dart';

import '/Backend/User_Creation/user_creator.dart';

void main() async {
  List<dynamic> ans = await UserCreator.createNewUser(
      email: "jon.perry@gmail.com", password: "welcome", name: "Jon Perry");
  print(ans[0]);
  ans = await UserCreator.createNewUser(
      email: "punchwood2003@gmail.com",
      password: "iPlanIsTheBest",
      name: "Matthew Sheldon");
  print(ans[0]);
  String jsonData = "{ \"financePage\": {}, \"calendarPage\": {}, \"itineraryPage\": {}, \"collaborationPage\": { \"title\": \"Event Name\", \"date\": \"April 25, 2022\", \"collaborators\": [ { \"name\": \"Matthew Sheldon\", \"email\": \"mts200002@utdallas.edu\", \"phoneNumber\": \"\", \"hasAccepted\": true }, { \"name\": \"Veda Charthad\", \"email\": \"\", \"phoneNumber\": \"(346) 970-8296\", \"hasAccepted\": true }, { \"name\": \"Casi Marquez\", \"email\": \"\", \"phoneNumber\": \"+1 (972) 370-4236\", \"hasAccepted\": false } ] } }";
  Map<String, dynamic> json = jsonDecode(jsonData);
  Event e = Event.fromJson(json: json, link: "ggaVFh6jrUqhVLlDl38w");
  FirebaseFirestore.instance
      .collection("events")
      .doc("ggaVFh6jrUqhVLlDl38w")
      .set(e.toJson());
}
