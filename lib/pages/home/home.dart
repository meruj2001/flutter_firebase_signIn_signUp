import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_signup/models/brew_model.dart';
import 'package:flutter_signin_signup/pages/home/brew_list.dart';
import 'package:flutter_signin_signup/pages/home/settings_form.dart';
import 'package:flutter_signin_signup/services/auth.dart';
import 'package:flutter_signin_signup/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettings() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<BrewModel>>.value(
      value: Database().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Home page'),
          actions: [
            FlatButton.icon(
              icon: Icon(
                Icons.person,
                color: Colors.brown[200],
              ),
              label: Text(
                'logout',
                style: TextStyle(color: Colors.brown[200]),
              ),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
            FlatButton.icon(
              icon: Icon(
                Icons.settings,
                color: Colors.brown[200],
              ),
              label: Text(
                'Settings',
                style: TextStyle(color: Colors.brown[200]),
              ),
              onPressed: () => _showSettings(),
            ),
          ],
        ),
        body: BrewList(),
      ),
    );
  }
}
