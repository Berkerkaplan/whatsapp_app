import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_app/core/services/locator.dart';
import 'package:whatsapp_app/viewmodels/sign_in_model.dart';

class SignInPage extends StatelessWidget {
  final TextEditingController _editingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => getIt<SignInModel>(),
      child: Consumer<SignInModel>(
        builder: (BuildContext context, SignInModel model, Widget child) =>
            Scaffold(
          appBar: AppBar(
            title: Text('Sign In for Whatsapp'),
          ),
          body: Container(
            padding: EdgeInsets.all(8.0),
            child: model.busy
                ? CircularProgressIndicator()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('User Name'),
                      TextField(
                        controller: _editingController,
                      ),
                      RaisedButton(
                        child: Text('Sign in'),
                        onPressed: () async =>
                            await model.signIn(_editingController.text),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
