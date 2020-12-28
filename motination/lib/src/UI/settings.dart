import 'package:flutter/material.dart';
import 'package:motination/models/user.dart';
import 'package:motination/services/database.dart';
import 'package:motination/shared/loading.dart';
import 'package:motination/src/UI/profile.dart';
import 'package:provider/provider.dart';
import 'package:motination/shared/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:motination/services/auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:age/age.dart';
import 'package:motination/src/authentication/SignIn.dart';
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
  final barColor = const Color(0xFF0A79DF);
  final bgColor = const Color(0xFFFEFDFD);
  final blue = const Color(0xff191970);
  String _vorname;
  String _nachname;
  String _benutzername;
  int trackrun;
  int points;
  String _currentgeschlecht;
  String _sumdistanz;
  String _sumtime;
  String _sumspeed;
  DateTime _currentalter;
  int statusalter = 0;
  int statusgeschlecht = 0;
  int statusgewicht = 0;
  int statusgroese = 0;
  String _stringalter;
  int _groese;
  String alter;
  String _newstringalter;
  String _newcurrentgeschlecht;
  String _newStringAlter1;
  String _newcurrentgeschlecht1;
  int _newgroese;
  int _groese1;
  double currentgewicht;
  double currentgewicht1;
  double _newgewicht;
  final AuthService _auth = AuthService();

  Future<void> getData(User user) async {
    try {
      DocumentSnapshot snapshot =
          await DatabaseService(uid: user.uid).getUserData();
      Map<String, dynamic> data = snapshot.data;
      setState(() {
        points = data["points"];
        trackrun = data["trackrun"];
        _sumdistanz = data["sumdistance"];
        _sumspeed = data["sumspeed"];
        _sumtime = data["sumtime"];
        _nachname = data["lastname"];
        _vorname = data["firstname"];
        _benutzername = data["username"];
        _stringalter = data["age"];
        _currentgeschlecht = data['sex'];
        _groese = data['height'];
        currentgewicht = data['weight'];
      });
    } catch (err) {
      print(err.toString());
    }
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
                initialDateTime: _currentalter,
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (datetime) {
                  setState(() {
                    statusalter = 1;
                    _currentalter = datetime;
                    _stringalter = _currentalter.toString();
                    _newStringAlter1 = randeralter(_stringalter);
                  });
                }),
          );
        });
  }

  _changealter() {
    if (statusalter == 0) {
      _newstringalter = _stringalter;
    }
    if (statusalter == 1) {
      _newstringalter = _newStringAlter1;
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

  void _showNumberGrosePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          //print(_currentgroese.toString());
          return Container(
            child: NumberPicker.integer(
                initialValue: _groese,
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

  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    getData(user);

    _changealter();
    _changegeschlecht();
    _changegroese();
    _changegewicht();
    return Scaffold(
        appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.black),
            title: Text(
              'Profil bearbeiten',
              style: Theme.of(context).textTheme.headline1,
            ),
            backgroundColor: bgColor),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://media-exp1.licdn.com/dms/image/C4D03AQG3wibhAzXXCA/profile-displayphoto-shrink_200_200/0/1573047022324?e=1611792000&v=beta&t=RF6cdGacErRqLLs90TuK1KW_H9jtKYplI_Z_9KJgc88'),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(50, 20, 50, 20),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: blue,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(_vorname + ' ' + _nachname,
                        style: GoogleFonts.spartan(
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w400))),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: (BoxDecoration(
                          border: Border(
                        top: BorderSide(width: 1, color: Colors.grey),
                      ))),
                    ),
                    Text(_benutzername,
                        style: GoogleFonts.spartan(
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 27,
                                fontWeight: FontWeight.w400))),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: (BoxDecoration(
                    border: Border(
                  bottom: BorderSide(width: 1, color: Colors.grey),
                ))),
              ),
              Row(children: <Widget>[
                Text(
                  'Geburstag:',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Spacer(),
                FlatButton(
                    onPressed: () {
                      _showCupertinoDatePicker(context);
                    },
                    child: Text(
                      (statusalter == 0)
                          ? _stringalter
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
              RaisedButton(
                  color: blue,
                  child: Text(
                    'Update',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    await DatabaseService(uid: user.uid).updateUserData(
                        _vorname,
                        _nachname,
                        _benutzername,
                        _newgroese,
                        _newstringalter,
                        _newgewicht,
                        user.uid,
                        _newcurrentgeschlecht,
                        _sumdistanz,
                        _sumtime,
                        _sumspeed,
                        trackrun,
                        points);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Profile()));
                  }),
              Spacer(),
              FlatButton.icon(
                  icon: Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  label: Text(
                    'A U S L O G G E N',
                    style: GoogleFonts.spartan(
                        textStyle: TextStyle(color: Colors.red)),
                  ),
                  onPressed: () async {
                    await _auth.signOut();
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context)=> SignIn()));
                  }),
              Spacer(),
            ],
          ),
        ));
  }
}
