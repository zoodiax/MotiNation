import 'package:flutter/material.dart';
import 'package:motination/models/user.dart';
import 'package:motination/services/database.dart';
import 'package:motination/shared/loading.dart';
import 'package:motination/src/UI/profile.dart';
import 'package:provider/provider.dart';
import 'package:motination/shared/constants.dart';

/* Settings Class UI Design
  Content: Update Button, TextField (LastName, FirstName, UserName, Age, Height, Weight)
  Function: DatabaseService(), Loading(), MaterialPageRoute -> (Profile, Challenge, Shop) 
*/

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final _formKey = GlobalKey<FormState>();

  String _currentvorname;
  String _currentnachname;
  String _currentalter;
  String _currentgroese;
  String _currentbenutzername;
  String _currentgewicht;
  String _currentuid;
  String _currentgeschlecht;

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Form(
                key: _formKey,
                child: Scaffold(
                  appBar: AppBar(
                    title: Text('Profil bearbeiten'),
                    backgroundColor: Colors.blue,
                  ),
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                          child: Column(
                        children: <Widget>[
                          Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Nachname:',
                                style: TextStyle(
                                    fontSize: 20, fontStyle: FontStyle.normal),
                              )),
                          TextFormField(
                              decoration: textInputDecoration.copyWith(
                                  hintText: 'Geben Sie ihren Nachnamen ein.'),
                              validator: (val) => val.isEmpty
                                  ? 'Geben Sie ihren Nachnamen ein.'
                                  : null,
                              onChanged: (val) {
                                setState(() => _currentnachname = val);
                              })
                        ],
                      )),
                      Expanded(
                          child: Column(
                        children: <Widget>[
                          Container(
                              child: Text(
                            'Vorname',
                            style: TextStyle(
                                fontSize: 15, fontStyle: FontStyle.normal),
                          )),
                          TextFormField(
                              decoration: textInputDecoration.copyWith(
                                  hintText: 'Geben Sie ihren Vornamen ein.'),
                              validator: (val) => val.isEmpty
                                  ? 'Geben Sie ihren Vornamen ein.'
                                  : null,
                              onChanged: (val) {
                                setState(() => _currentvorname = val);
                              })
                        ],
                      )),
                      Expanded(
                          child: Column(
                        children: <Widget>[
                          Container(
                              child: Text(
                            'Benutzername',
                            style: TextStyle(
                                fontSize: 15, fontStyle: FontStyle.normal),
                          )),
                          TextFormField(
                              decoration: textInputDecoration.copyWith(
                                  hintText: 'Geben Sie einen Benutzername ein.'),
                              validator: (val) => val.isEmpty
                                  ? 'Geben Sie einen Benutzername ein.'
                                  : null,
                              onChanged: (val) {
                                setState(() => _currentbenutzername = val);
                              })
                        ],
                      )),
                      Expanded(
                          child: Column(
                        children: <Widget>[
                          Container(
                              child: Text(
                            'Alter',
                            style: TextStyle(
                                fontSize: 15, fontStyle: FontStyle.normal),
                          )),
                          TextFormField(
                              decoration: textInputDecoration.copyWith(
                                  hintText: 'Geben Sie ihr Alter ein.'),
                              validator: (val) => val.isEmpty
                                  ? 'Geben Sie ihr Alter ein.'
                                  : null,
                              onChanged: (val) {
                                setState(() => _currentalter = val);
                              })
                        ],
                      )),
                      Expanded(
                          child: Column(
                        children: <Widget>[
                          Container(
                              child: Text(
                            'Größe',
                            style: TextStyle(
                                fontSize: 15, fontStyle: FontStyle.normal),
                          )),
                          TextFormField(
                              decoration: textInputDecoration.copyWith(
                                  hintText: 'Geben Sie ihre Größe ein.'),
                              validator: (val) => val.isEmpty
                                  ? 'Geben Sie ihre Größe ein.'
                                  : null,
                              onChanged: (val) {
                                setState(() => _currentgroese = val);
                              })
                        ],
                      )),
                      Expanded(
                          child: Column(
                        children: <Widget>[
                          Container(
                              child: Text(
                            'Gewicht',
                            style: TextStyle(
                                fontSize: 15, fontStyle: FontStyle.normal),
                          )),
                          TextFormField(
                              decoration: textInputDecoration.copyWith(
                                  hintText: 'Geben Sie ihr Gewicht ein.'),
                              validator: (val) => val.isEmpty
                                  ? 'Geben Sie ihr Gewicht ein.'
                                  : null,
                              onChanged: (val) {
                                setState(() => _currentgewicht = val);
                              })
                        ],
                      )),
                      Expanded(
                          child: Column(
                        children: <Widget>[
                          Container(
                              child: Text(
                            'Geschlecht',
                            style: TextStyle(
                                fontSize: 15, fontStyle: FontStyle.normal),
                          )),
                          TextFormField(
                              decoration: textInputDecoration.copyWith(
                                  hintText: 'Geben Sie ihr Geschlecht ein.'),
                              validator: (val) => val.isEmpty
                                  ? 'Geben Sie ihr Geschlecht ein.'
                                  : null,
                              onChanged: (val) {
                                setState(() => _currentgeschlecht = val);
                              })
                        ],
                      )),                      
                      RaisedButton(
                          color: Colors.blue[400],
                          child: Text(
                            'Update',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              await DatabaseService(uid: user.uid)
                                  .updateUserData(
                                _currentvorname ?? userData.vorname,
                                _currentnachname ?? userData.nachname,
                                _currentbenutzername ?? userData.benutzername,
                                _currentgroese ?? userData.groese,
                                _currentalter ?? userData.alter,
                                _currentgewicht ?? userData.gewicht,
                                _currentuid ?? userData.uid,
                                _currentgeschlecht ?? userData.geschlecht,
                                userData.trackrun,
                                userData.sumspeed,
                                userData.sumtime,
                                userData.sumdistanz
                              );
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Profile()));
                            }
                          }),
                    ],
                  ),
                ));
          } else {
            return Loading();
          }
          
         //du schwanz
        });
  }
}
