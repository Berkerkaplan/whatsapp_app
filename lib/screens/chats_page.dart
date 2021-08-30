import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_app/models/conversation.dart';
import 'package:whatsapp_app/screens/conversation.page.dart';
import 'package:whatsapp_app/viewmodels/chat_model.dart';

class ChatsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var model = GetIt.instance<ChatsModel>();
    var user = Provider.of<FirebaseUser>(context);

    return ChangeNotifierProvider(
      create: (BuildContext context) => model,
      child: StreamBuilder<List<Conversation>>(
        stream: model.conversations(user.uid),
        builder:
            (BuildContext context, AsyncSnapshot<List<Conversation>> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Loading...');
          }
          return ListView(
            children: snapshot.data
                .map(
                  (doc) => ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(doc.profileImage),
                    ),
                    title: Text(doc.name),
                    subtitle: Text(doc.displayMessage),
                    trailing: Column(
                      children: [
                        Text('19:30'),
                        Container(
                          width: 20.0,
                          height: 20.0,
                          margin: EdgeInsets.only(top: 8.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).accentColor,
                          ),
                          child: Center(
                            child: Text(
                              '16',
                              textScaleFactor: 0.8,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ConversationPage(
                                    userId: user.uid,
                                    conversation: doc,
                                  )));
                    },
                  ),
                )
                .toList(),
          );
        },
      ),
    );
  }
}
