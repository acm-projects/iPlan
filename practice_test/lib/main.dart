import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

import 'Backend/Collaboration/Invite_Collaborator/invite_collaborator.dart';
import 'Backend/Collaboration/collaboration_page.dart';
import 'Backend/Collaboration/Collaborator/collaborator.dart';
import 'Frontend/Collaboratoin/collaboration.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  CollaborationPage collaborationPage = CollaborationPage(
      title: "Event Name",
      date: "April 25, 2022",
      link: "ggaVFh6jrUqhVLlDl38w");
  await collaborationPage.constructorHelperMethod();
  Contact matthew =
      collaborationPage.getContactsFromSearch(substring: "Matthew Sheldon")[0];
  collaborationPage.addCollaborator(
      contact: matthew, useEmail: true, hasAccepted: true);
  Contact veda =
      collaborationPage.getContactsFromSearch(substring: "Veda")[0];
  collaborationPage.addCollaborator(
      contact: veda, useEmail: false, hasAccepted: true);
  Contact casi =
      collaborationPage.getContactsFromSearch(substring: "Casi")[0];
  collaborationPage.addCollaborator(
      contact: casi, useEmail: false, hasAccepted: false);
  InviteCollaborator inviteCollaborator = InviteCollaborator();
  TextEditingController searchBarTextRetrieval = TextEditingController();
  runApp(Collaboration(
      collaborationPage: collaborationPage,
      inviteCollaborator: inviteCollaborator,
      searchBarTextRetrieval: searchBarTextRetrieval));
}
