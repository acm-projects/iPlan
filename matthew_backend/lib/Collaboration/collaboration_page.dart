import '../page_type.dart';
import 'Contact_Search/contact_mapper.dart';
import 'Contact_Search/contact_puller.dart';
import 'collaborator.dart';

///
class CollaborationPage {
  /// The list of [Collaborator] objects for the current event
  late List<Collaborator> _collaborators;

  /// The mapping between names of contacts and [Contact] objects
  late ContactMap contactMap;

  /// The tool used to request contact permissions and 
  late ContactPuller contactPuller;

  ///
  late String _inviteLink;

  ///
  late String _title;

  ///
  late String _date;

  ///
  CollaborationPage({required String title, required String date}) {
    _title = title;
    _date = date;
  }

  ///
  PageType backButton() {
    return PageType.homeScreen;
  }

  ///
  String getTitle() {
    return _title;
  }

  ///
  String getDate() {
    return _date;
  }

  ///
  String getInviteLink() {
    return _inviteLink;
  }

  ///
  getCollaborators() {
    return _collaborators;
  }
}
