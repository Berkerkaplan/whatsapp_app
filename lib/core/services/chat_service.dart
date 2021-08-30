import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';
import 'package:whatsapp_app/models/conversation.dart';
import 'package:whatsapp_app/models/profile.dart';

class ChatService {
  final Firestore _firestore = Firestore.instance;

  Stream<List<Conversation>> getConversations(String userId) {
    var ref = _firestore
        .collection('conversations')
        .where('members', arrayContains: userId);

    var conversationsStream = ref.snapshots();

    var profilesStreams = getContacts().asStream();

    return Rx.combineLatest2(
      conversationsStream,
      profilesStreams,
      (QuerySnapshot conversations, List<Profile> profiles) =>
          conversations.documents.map((snapshot) {
        List<String> members = List.from(snapshot['members']);

        var profile = profiles.firstWhere(
          (element) =>
              element.id == members.firstWhere((member) => member != userId),
        );

        return Conversation.fromSnapshot(snapshot, profile);
      }).toList(),
    );

    // return ref.snapshots().map((list) => list.documents
    //     .map((snapshot) => Conversation.fromSnapshot(snapshot))
    //     .toList());
  }

  Future<List<Profile>> getContacts() async {
    //servisten tüm kişileri çekip yazdıracaz
    var ref = _firestore.collection('profile');

    var documents = await ref.getDocuments();

    return documents.documents
        .map((snapshot) => Profile.fromSnapshot(snapshot))
        .toList();
  }

  Future<Conversation> startConversation(
      FirebaseUser user, Profile profile) async {
    var ref = _firestore.collection('conversations');

    var documentRef = await ref.add({
      'displayMessage': '',
      'members': [user.uid, profile.id],
    });

    return Conversation(
      id: documentRef.documentID,
      displayMessage: '',
      name: profile.userName,
      profileImage: profile.image,
    );
  }
}
