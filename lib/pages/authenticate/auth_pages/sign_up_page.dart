import 'package:flutter/material.dart';
import 'package:flutter_signin_signup/pages/loading.dart';
import 'package:flutter_signin_signup/services/auth.dart';

import '../../../constant_widget.dart';

class SignUpPage extends StatefulWidget {
  final Function toggleView;

  SignUpPage({this.toggleView});
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final AuthService _authService = AuthService();

  final _formKey = GlobalKey<FormState>();

  bool loading = false;

  String email = '';
  String password = '';

  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[500],
              title: Text('Sign In'),
              actions: [
                FlatButton.icon(
                  icon: Icon(
                    Icons.person,
                  ),
                  label: Text('Sign In'),
                  onPressed: widget.toggleView,
                ),
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 40.0,
                    ),
                    TextFormField(
                      decoration: textInputDecoration(hintText: 'Email'),
                      validator: (val) => val.isEmpty ? 'Enter an email' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      decoration: textInputDecoration(hintText: 'Password'),
                      validator: (val) => val.length < 6
                          ? 'password must be at least 6 characters'
                          : null,
                      obscureText: true,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    RaisedButton(
                      color: Colors.brown[600],
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() => loading = true);
                          dynamic result = await _authService
                              .signUpWithEmailAndPassword(email, password);
                          if (result == null) {
                            setState(() => loading = false);
                            setState(
                                () => error = 'please supply a valid email');
                          }
                        }
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Center(
                      child: Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
