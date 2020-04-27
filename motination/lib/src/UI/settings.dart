import 'package:flutter/material.dart';
import 'package:motination/services/database.dart';
import 'package:provider/provider.dart';
import 'user_list.dart';
import 'package:motination/models/motination.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<MotiNation>>.value(
          value: DatabaseService().mNUser,
          child: Scaffold(
        appBar: AppBar(
          title: Text('Einstellungen'),
          backgroundColor: Colors.blue,
        ),

        body:
        Column(
          children: <Widget>[
         Container(
          child: Text('Name')
        ),
        Container(
          child: Text('Name aus der Datenbank'),
        ),
          ],
        ),
        ),
    );

    
  }
}