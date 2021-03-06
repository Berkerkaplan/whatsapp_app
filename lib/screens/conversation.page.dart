import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_app/models/conversation.dart';

class ConversationPage extends StatefulWidget {
  final String userId;
  final Conversation conversation;

  ConversationPage({this.userId, this.conversation});

  @override
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  final TextEditingController _editingController = TextEditingController();
  CollectionReference _ref;
  FocusNode _focusNode;
  ScrollController _scrollController;

  @override
  void initState() {
    _ref = Firestore.instance
        .collection('conversation/${widget.conversation.id}/messages');

    _focusNode = FocusNode();
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: -5,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.conversation.profileImage),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(widget.conversation.name),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: InkWell(
              child: Icon(Icons.phone),
              onTap: () {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: InkWell(
              child: Icon(Icons.camera_alt),
              onTap: () {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: InkWell(
              child: Icon(Icons.more_vert),
              onTap: () {},
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
                'https://en.wikipedia.org/wiki/Van_cat#/media/File:VAN_CAT.png'),
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  _focusNode.unfocus();
                },
                child: StreamBuilder(
                  stream: _ref.orderBy('timeStamp').snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    return !snapshot.hasData
                        ? CircularProgressIndicator()
                        : ListView(
                            controller: _scrollController,
                            children: snapshot.data.documents
                                .map(
                                  (document) => ListTile(
                                    title: Align(
                                      alignment:
                                          widget.userId != document['sender']
                                              ? Alignment.centerRight
                                              : Alignment.centerLeft,
                                      child: Container(
                                        padding: EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius: BorderRadius.horizontal(
                                            left: Radius.circular(10.0),
                                            right: Radius.circular(10.0),
                                          ),
                                        ),
                                        child: Text(
                                          document['message'],
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          );
                  },
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(25.0),
                        right: Radius.circular(25.0),
                      ),
                    ),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: InkWell(
                            child: Icon(
                              Icons.tag_faces,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            focusNode: _focusNode,
                            controller: _editingController,
                            decoration: InputDecoration(
                              hintText: 'Type a message',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        InkWell(
                          child: Icon(
                            Icons.attach_file,
                            color: Colors.grey,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            child: Icon(
                              Icons.camera,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 5.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).primaryColor,
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      await _ref.add({
                        'senderId': widget.userId,
                        'message': _editingController.text,
                        'timeStamp': DateTime.now(),
                      });

                      _scrollController.animateTo(
                        _scrollController.position.maxScrollExtent,
                        duration: Duration(milliseconds: 200),
                        curve: Curves.easeIn,
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
