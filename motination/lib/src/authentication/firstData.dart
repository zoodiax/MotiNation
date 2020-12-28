import 'dart:ui';
import 'package:motination/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:motination/src/UI/Run/running.dart';
import 'package:motination/services/sharedPref.dart';
import 'package:motination/services/database.dart';
import 'package:provider/provider.dart';
import 'package:motination/models/user.dart';

class FirstData extends StatefulWidget {
  @override
  _FirstDataState createState() => _FirstDataState();
}

class _FirstDataState extends State<FirstData> {
  String _currentvorname;
  String _currentalter;
  int _currentgroese;
  double _currentgewicht;
  String _currentgeschlecht;
  String _currentnachname;
  String _currentusername;

  final SharedPref _shared = SharedPref();

  _sendFirstData(User user) {
    return RawMaterialButton(
        constraints: BoxConstraints(minHeight: 60),
        fillColor: blue,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(color: blue)),
        onPressed: () async {
          await _shared.addIntToSP(intKey, 0);
          // User in firebase anlegen
          await DatabaseService(uid: user.uid).setUserData(
            _currentvorname,
            _currentnachname,
            _currentusername,
            180,//_currentgroese,
            _currentalter,
            80.0,//_currentgewicht,
            _currentgeschlecht,
            user.uid,
          );
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Running()));
        },
        child: Text("     Los geht's!     ",
            style: Theme.of(context).textTheme.headline2));
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    return new WillPopScope(
        onWillPop: () async => false,
        child: 
          Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Text('Motination',
                    style: Theme.of(context).textTheme.headline1),
                backgroundColor: bgColor,
              ),
              body: 
              SingleChildScrollView(
                 child: Stack(children: [Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    //Spacer(),
                    // Expanded(
                    //     child: 
                    Column(
                      children: <Widget>[
                        Container(
                          height: 20,
                        ),
                        Container(
                            child: Text(
                          'Dein Vorname',
                          style: TextStyle(
                              fontSize: 15, fontStyle: FontStyle.normal),
                        )),
                        TextFormField(
                            
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Gebe deinen Vornamen ein.'),
                            validator: (val) => val.isEmpty
                                ? 'Gebe deinen Vornamen ein.'
                                : null,
                            onChanged: (val) {
                              setState(() => _currentvorname = val);
                            })
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          height: 20,
                        ),
                        Container(
                            child: Text(
                          'Dein Nachname',
                          style: TextStyle(
                              fontSize: 15, fontStyle: FontStyle.normal),
                        )),
                        TextFormField(
                            
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Gebe dein Nachname ein.'),
                            validator: (val) => val.isEmpty
                                ? 'Gebe dein Nachnamen ein.'
                                : null,
                            onChanged: (val) {
                              setState(() => _currentnachname = val);
                            })
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          height: 20,
                        ),
                        Container(
                            child: Text(
                          'Dein Benutzername',
                          style: TextStyle(
                              fontSize: 15, fontStyle: FontStyle.normal),
                        )),
                        TextFormField(
                            
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Gebe dein Benutzername ein.'),
                            validator: (val) => val.isEmpty
                                ? 'Gebe dein Benutzername ein.'
                                : null,
                            onChanged: (val) {
                              setState(() => _currentusername = val);
                            })
                      ],
                    ),

                    // ),
                    // Expanded(
                    //     child: 
                        Column(
                      children: <Widget>[
                         Container(
                          height: 20,
                        ),
                        Container(
                            child: Text(
                          'Dein Alter',
                          style: TextStyle(
                              fontSize: 15, fontStyle: FontStyle.normal),
                        )),
                        TextFormField(
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Gebe dein Alter ein.'),
                            validator: (val) =>
                                val.isEmpty ? 'Gebe dein Alter ein.' : null,
                            onChanged: (val) {
                              setState(() => _currentalter = val);
                            })
                      ],
                    // )
                    ),
                    // Expanded(
                    //     child: 
                        Column(
                          
                      children: <Widget>[
                         Container(
                          height: 20,
                        ),
                        Container(
                            child: Text(
                          'Deine Größe',
                          style: TextStyle(
                              fontSize: 15, fontStyle: FontStyle.normal),
                        )),
                        TextFormField(
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Gebe deine Größe ein.'),
                            validator: (val) =>
                                val.isEmpty ? 'Gebe deine Größe ein.' : null,
                            onChanged: (val) {
                              setState(() => _currentgroese = int.parse(val));
                            })
                      ],
                    // )
                    ),
                    // Expanded(
                    //     child: 
                        Column(
                      children: <Widget>[
                         Container(
                          height: 20,
                        ),
                        Container(
                            child: Text(
                          'Dein Gewicht',
                          style: TextStyle(
                              fontSize: 15, fontStyle: FontStyle.normal),
                        )),
                        TextFormField(
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Gebe dein Gewicht ein.'),
                            validator: (val) =>
                                val.isEmpty ? 'Gebe dein Gewicht ein.' : null,
                            onChanged: (val) {
                              setState(() => _currentgewicht = double.parse(val));
                            })
                      ],
                    // )
                    ),
                    // Expanded(
                    //     child: 
                        Column(
                      children: <Widget>[
                         Container(
                          height: 20,
                        ),
                        Container(
                            child: Text(
                          'Dein Geschlecht',
                          style: TextStyle(
                              fontSize: 15, fontStyle: FontStyle.normal),
                        )),
                        TextFormField(
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Gebe dein Geschlecht ein.'),
                            validator: (val) => val.isEmpty
                                ? 'Gebe dein Geschlecht ein.'
                                : null,
                            onChanged: (val) {
                              setState(() => _currentgeschlecht = val);
                            })
                      ],
                    // )
                    ),
                     Container(
                          height: 20,
                        ),
                    _sendFirstData(user),
                    //Spacer(),
                  ])])
        )));
  }
}
