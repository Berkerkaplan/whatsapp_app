import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_app/core/services/locator.dart';
import 'package:whatsapp_app/core/services/navigator_service.dart';
import 'package:whatsapp_app/screens/sign_in_page.dart';
import 'package:whatsapp_app/viewmodels/sign_in_model.dart';
import 'package:whatsapp_app/whatsapp_main.dart';

void main() {
  setUpLocator();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureProvider(
      create: (context) => getIt<SignInModel>().currentUser,
      child: MaterialApp(
        title: 'Flutter Demo',
        navigatorKey: getIt<NavigatorService>().navigatorKey,
        theme: ThemeData(
          primaryColor: Color(0xff075E54),
          accentColor: Color(0xff25D366),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Consumer<FirebaseUser>(
          builder: (BuildContext context, FirebaseUser user, Widget child) =>
              user == null ? SignInPage() : WhatsAppMain(),
        ),
      ),
    );
  }
}
