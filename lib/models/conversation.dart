import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsapp_app/models/profile.dart';

class Conversation {
  String id;
  String name;
  String profileImage;
  String displayMessage;

  Conversation({this.id, this.name, this.displayMessage, this.profileImage});

  factory Conversation.fromSnapshot(
      DocumentSnapshot snapshot, Profile profile) {
    return Conversation(
        id: snapshot.documentID,
        name: profile.userName,
        profileImage: profile.image,
        displayMessage: snapshot.data['displayMessage']);
  }
}
