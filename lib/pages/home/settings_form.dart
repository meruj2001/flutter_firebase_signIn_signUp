import 'package:flutter/material.dart';
import 'package:flutter_signin_signup/constant_widget.dart';
import 'package:flutter_signin_signup/models/user_model.dart';
import 'package:flutter_signin_signup/pages/loading.dart';
import 'package:flutter_signin_signup/services/database.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4', '5'];

  String _currentName;
  String _currentSugars;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);

    return StreamBuilder<UserDataModel>(
      stream: Database(uid: user.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserDataModel userData = snapshot.data;
          return Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  'Update your brew settings.',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  initialValue: userData.name,
                  decoration: textInputDecoration(hintText: 'Name'),
                  validator: (val) =>
                      val.isEmpty ? 'Please enter a name' : null,
                  onChanged: (val) => setState(
                    () => _currentName = val,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                // dropdown
                DropdownButtonFormField(
                  decoration: textInputDecoration(),
                  value: _currentSugars ?? userData.sugars,
                  items: sugars.map((sugar) {
                    return DropdownMenuItem(
                      value: sugar,
                      child: Text('$sugar sugars'),
                    );
                  }).toList(),
                  onChanged: (val) => setState(() => _currentSugars = val),
                ),
                // slider
                Slider(
                  activeColor: Colors.brown[_currentStrength ?? 100],
                  inactiveColor: Colors.brown[_currentStrength ?? 100],
                  value: (_currentStrength ?? userData.strength).toDouble(),
                  min: 100.0,
                  max: 900.0,
                  divisions: 8,
                  onChanged: (val) =>
                      setState(() => _currentStrength = val.round()),
                ),

                RaisedButton(
                  color: Colors.brown[600],
                  child: Text(
                    'Update',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      await Database(uid: user.uid).updateUserData(
                          _currentSugars, _currentName, _currentStrength);
                    }
                  },
                ),
              ],
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}
