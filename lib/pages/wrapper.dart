import 'package:flutter/material.dart';
import 'package:flutter_signin_signup/models/user_model.dart';
import 'package:flutter_signin_signup/pages/authenticate/authenticate.dart';
import 'package:flutter_signin_signup/pages/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);

    return user != null ? Home() : Authenticate();
  }
}
