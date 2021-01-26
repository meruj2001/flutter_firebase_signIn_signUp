import 'package:flutter/material.dart';
import 'auth_pages/sign_in_page.dart';
import 'auth_pages/sign_up_page.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    return showSignIn
        ? SignInPage(
            toggleView: toggleView,
          )
        : SignUpPage(
            toggleView: toggleView,
          );
  }
}
