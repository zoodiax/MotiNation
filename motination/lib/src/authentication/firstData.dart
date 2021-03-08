import 'dart:ui';
import 'package:motination/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:motination/src/UI/Run/running.dart';
import 'package:motination/services/sharedPref.dart';
import 'package:motination/services/database.dart';
import 'package:provider/provider.dart';
import 'package:motination/models/user.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:numberpicker/numberpicker.dart';


class FirstData extends StatefulWidget {
  @override
  _FirstDataState createState() => _FirstDataState();
}

class _FirstDataState extends State<FirstData> {
  String _currentvorname;
  //int _currentgroese=180;
  double currentgewicht=80.0;
  String _currentgeschlecht= '' ;
  String _currentnachname;
  String _currentusername;
  //int _newcurrentgroese;
  //double _newcurrentgewicht;
  DateTime _currentdate = DateTime.now();
  //DateTime _currentalter;
  String _stringalter;
  int statusalter = 0;
  String _newStringAlter1;
  String _newstringalter;
  int statusgroese = 0;
  int _groese = 180;
  int _groese1;
  int _newgroese;
  int statusgewicht = 0;
  double currentgewicht1;
  double _newgewicht;
  int statusgeschlecht = 0;
  String _newcurrentgeschlecht;
  String _newcurrentgeschlecht1;

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
            _newgroese, //_currentgroese,
            _newstringalter,
            _newgewicht, //_currentgewicht,
            _newcurrentgeschlecht,
            user.uid,
            
          );
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Running()));
        },
        child: Text("     Los geht's!     ",
            style: Theme.of(context).textTheme.headline2));
  }

  String randeralter(String date) {
    return date.substring(0, 10);
  }

  void _showCupertinoDatePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            child: CupertinoDatePicker(
                initialDateTime: _currentdate,
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (datetime) {
                  setState(() {
                   statusalter = 1;
                    _currentdate = datetime;
                    _stringalter = _currentdate.toString();
                    _newStringAlter1 = randeralter(_stringalter);
                  });
                }),
          );
        });
  }
  _changealter() {
    if (statusalter == 0) {
      _newstringalter = _currentdate.toString();
    }
    if (statusalter == 1) {
      _newstringalter = _newStringAlter1;
    }
  }
  void _showNumberGrosePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          //print(_currentgroese.toString());
          return Container(
            child: NumberPicker.integer(
                initialValue: _groese=180,
                minValue: 120,
                maxValue: 280,
                onChanged: (currentgroese) {
                  setState(
                    () {
                      statusgroese = 1;
                      _groese = currentgroese;
                      _groese1 = _groese;
                      //print(_groese);
                    },
                  );
                }),
          );
        });
  }

  void _changegroese() {
    if (statusgroese == 0) {
      _newgroese = _groese;
    }
    if (statusgroese == 1) {
      _newgroese = _groese1;
    }
  }

  void _showCupertinoWeightPicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            child: NumberPicker.decimal(
                minValue: 20,
                maxValue: 200,
                initialValue: currentgewicht,
                onChanged: (_currentgewicht) {
                  setState(
                    () {
                      statusgewicht = 1;
                      currentgewicht = _currentgewicht;
                      currentgewicht1 = currentgewicht;
                    },
                  );
                }),
          );
        });
  }

  void _changegewicht() {
    if (statusgewicht == 0) {
      _newgewicht = currentgewicht;
    }
    if (statusgewicht == 1) {
      _newgewicht = currentgewicht1;
    }
  }
  void _showCupertinoMalePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            child: CupertinoPicker(
              itemExtent: 50,
              onSelectedItemChanged: (male) {
                setState(() {
                  statusgeschlecht = 1;
                  if (male == 0) {
                    _currentgeschlecht = 'männlich';
                  }
                  if (male == 1) {
                    _currentgeschlecht = 'weiblich';
                  }
                  if (male == 2) {
                    _currentgeschlecht = 'divers';
                  }
                  _newcurrentgeschlecht1 = _currentgeschlecht;
                });
              },
              children: <Widget>[
                Text("männlich"),
                Text("weiblich"),
                Text("divers"),
              ],
            ),
          );
        });
  }

  void _changegeschlecht() {
    if (statusgeschlecht == 0) {
      _newcurrentgeschlecht = _currentgeschlecht;
    }
    if (statusgeschlecht == 1) {
      _newcurrentgeschlecht = _newcurrentgeschlecht1;
    }
  }
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
  _changealter();
  _changegroese();
  _changegewicht();
  _changegeschlecht();
    return new WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text('Motination',
                  style: Theme.of(context).textTheme.headline1),
              backgroundColor: bgColor,
            ),
            body: Container(
                padding: EdgeInsets.all(10),
                child: SingleChildScrollView(
                    child: Stack(children: [
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        
                        Row(
                          children: <Widget>[
                            Container(
                              height: 20,
                            ),
                            Container(
                                child: Text(
                              'Vorname:',
                              style: GoogleFonts.spartan(
                                  fontSize: 18, fontStyle: FontStyle.normal),
                            )),
                            Flexible(
                                child: TextFormField(
                                    decoration: textInputDecoration.copyWith(
                                        hintText: 'Gebe deinen Vornamen ein.'),
                                    validator: (val) => val.isEmpty
                                        ? 'Gebe deinen Vornamen ein.'
                                        : null,
                                    onChanged: (val) {
                                      setState(() => _currentvorname = val);
                                    }))
                          ],
                        ),

                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: (BoxDecoration(
                              border: Border(
                            bottom: BorderSide(width: 1, color: Colors.grey),
                          ))),
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 20,
                            ),
                            Container(
                                child: Text(
                              'Nachname:',
                              style: GoogleFonts.spartan(
                                  fontSize: 18, fontStyle: FontStyle.normal),
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

                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: (BoxDecoration(
                              border: Border(
                            bottom: BorderSide(width: 1, color: Colors.grey),
                          ))),
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 20,
                            ),
                            Container(
                                child: Text(
                              'Benutzername',
                              style: GoogleFonts.spartan(
                                  fontSize: 18, fontStyle: FontStyle.normal),
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

                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: (BoxDecoration(
                              border: Border(
                            bottom: BorderSide(width: 1, color: Colors.grey),
                          ))),
                        ),
                      
                        Row(children: <Widget>[
                Text(
                  'Geburtstag:',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Spacer(),
                FlatButton(
                    onPressed: () {
                      _showCupertinoDatePicker(context);
                    },
                    child: Text(
                      (statusalter == 0)
                          ? randeralter(_currentdate.toString())
                          : randeralter(_newStringAlter1),
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    color: Colors.white),
              ]),
                       Container(
                padding: EdgeInsets.all(5),
                decoration: (BoxDecoration(
                    border: Border(
                  top: BorderSide(width: 1, color: Colors.grey),
                ))),
              ),
              Row(children: <Widget>[
                Text(
                  'Größe:',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Spacer(),
                FlatButton(
                  color: Colors.white,
                  onPressed: () {
                    _showNumberGrosePicker(context);
                  },
                  child: Text(
                    (statusgroese == 0)
                        ? _groese.toString() + ' cm'
                        : _groese1.toString() + ' cm',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ]),
                        Container(
                padding: EdgeInsets.all(5),
                decoration: (BoxDecoration(
                    border: Border(
                  top: BorderSide(width: 1, color: Colors.grey),
                ))),
              ),
              Row(children: <Widget>[
                Text(
                  'Gewicht:',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Spacer(),
                FlatButton(
                  color: Colors.white,
                  onPressed: () {
                    _showCupertinoWeightPicker(context);
                  },
                  child: Text(
                    (statusgewicht == 0)
                        ? currentgewicht.toString() + ' kg'
                        : currentgewicht1.toString() + ' kg',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ]),    
                        Container(
                padding: EdgeInsets.all(5),
                decoration: (BoxDecoration(
                    border: Border(
                  top: BorderSide(width: 1, color: Colors.grey),
                ))),
              ),
             Row(children: <Widget>[
                Text(
                  'Geschlecht:',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Spacer(),
                FlatButton(
                  color: Colors.white,
                  onPressed: () {
                    _showCupertinoMalePicker(context);
                  },
                  child: Text(
                    (statusgeschlecht == 0)
                        ? _currentgeschlecht
                        : _newcurrentgeschlecht1,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ]),
              Container(
                padding: EdgeInsets.all(5),
                decoration: (BoxDecoration(
                    border: Border(
                  top: BorderSide(width: 1, color: Colors.grey),
                ))),
              ),
                        Container(
                          height: 20,
                        ),
                        _sendFirstData(user),
                        
                      ])
                ])))));
  }
}
