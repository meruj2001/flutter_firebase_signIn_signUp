import 'package:flutter/material.dart';
import 'package:flutter_signin_signup/models/user_model.dart';
import 'package:flutter_signin_signup/services/auth.dart';
import 'package:provider/provider.dart';
import 'pages/home/home.dart';
import 'pages/loading.dart';
import 'pages/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          print('error');
          return Home();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          print('wrapper');
          return StreamProvider<UserModel>.value(
            value: AuthService().user,
            child: MaterialApp(
              home: Wrapper(),
            ),
          );
        }

        print('loading');
        // Otherwise, show something whilst waiting for initialization to complete
        return MaterialApp(
          home: Loading(),
        );
      },
    );
  }
}
