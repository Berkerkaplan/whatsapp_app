import 'package:flutter/material.dart';
import 'package:whatsapp_app/core/services/locator.dart';
import 'package:whatsapp_app/screens/calls_page.dart';
import 'package:whatsapp_app/screens/camera_page.dart';
import 'package:whatsapp_app/screens/chats_page.dart';
import 'package:whatsapp_app/screens/contacts_page.dart';
import 'package:whatsapp_app/screens/status_page.dart';
import 'package:whatsapp_app/viewmodels/main_model.dart';
import 'package:whatsapp_app/viewmodels/whatsapp_main_model.dart';

class WhatsAppMain extends StatefulWidget {
  @override
  _WhatsAppMainState createState() => _WhatsAppMainState();
}

class _WhatsAppMainState extends State<WhatsAppMain>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  bool _showMessage = true;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this, initialIndex: 1);
    _showMessage = _tabController.index != 0;
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var model = getIt<MainModel>();
    return Scaffold(
      floatingActionButton: _showMessage
          ? FloatingActionButton(
              onPressed: () async {
                await model.navigateToContact();
              },
              child: Icon(
                Icons.message,
                color: Colors.white,
              ),
            )
          : null,
      body: Container(
        color: Theme.of(context).primaryColor,
        child: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  //App barı gizlememize yarıyor
                  floating: true,
                  title: Text('Whatsapp'),
                  actions: [
                    IconButton(icon: Icon(Icons.search), onPressed: null),
                    IconButton(icon: Icon(Icons.more_vert), onPressed: null),
                  ],
                ),
              ];
            },
            body: Column(
              children: [
                TabBar(
                  controller: _tabController,
                  tabs: <Widget>[
                    Tab(
                      icon: Icon(Icons.camera),
                    ),
                    Tab(
                      text: 'Chats',
                    ),
                    Tab(
                      text: 'Status',
                    ),
                    Tab(
                      text: 'Calls',
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: TabBarView(
                      controller: _tabController,
                      children: <Widget>[
                        CameraPage(),
                        ChatsPage(),
                        StatusPage(),
                        CallsPage(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
