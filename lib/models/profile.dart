import 'package:cloud_firestore/cloud_firestore.dart';

class Profile {
  String id;
  String userName;
  String image;

  Profile({this.userName, this.id, this.image});

  factory Profile.fromSnapshot(DocumentSnapshot snapshot) {
    return Profile(
      id: snapshot.documentID,
      userName: snapshot['userName'],
      image: snapshot['image'],
    );
  }
}
