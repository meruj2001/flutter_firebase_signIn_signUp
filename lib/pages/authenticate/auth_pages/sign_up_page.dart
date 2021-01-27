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
  final List<String> sugars = ['0', '1', '2', '3', '4', '5'];

  String _currentName;
  String _currentSugars;
  int _currentStrength;

  bool loading = false;

  String email = '';
  String password = '';

  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[50],
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
                      height: 10.0,
                    ),
                    TextFormField(
                      decoration: textInputDecoration(hintText: 'Email'),
                      validator: (val) => val.isEmpty ? 'Enter an email' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(
                      height: 10.0,
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
                      height: 10.0,
                    ),
                    TextFormField(
                      decoration: textInputDecoration(hintText: 'Name'),
                      validator: (val) =>
                          val.isEmpty ? 'Please enter a name' : null,
                      onChanged: (val) => setState(
                        () => _currentName = val,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    DropdownButtonFormField(
                      decoration: textInputDecoration(),
                      value: _currentSugars ?? sugars[2],
                      items: sugars.map((sugar) {
                        return DropdownMenuItem(
                          value: sugar,
                          child: Text('$sugar sugars'),
                        );
                      }).toList(),
                      onChanged: (val) => setState(() => _currentSugars = val),
                    ),
                    Slider(
                      activeColor: Colors.brown[_currentStrength ?? 100],
                      inactiveColor: Colors.brown[_currentStrength ?? 100],
                      value: (_currentStrength ?? 100).toDouble(),
                      min: 100.0,
                      max: 900.0,
                      divisions: 8,
                      onChanged: (val) =>
                          setState(() => _currentStrength = val.round()),
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
                              .signUpWithEmailAndPassword(
                                email: email,
                                password: password,
                                name: _currentName,
                                sugar: _currentSugars,
                                strength: _currentStrength,
                              );
                          if (result == null) {
                            setState(() => loading = false);
                            setState(
                                () => error = 'please supply a valid email');
                          }
                        }
                      },
                    ),
                    SizedBox(
                      height: 10.0,
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
