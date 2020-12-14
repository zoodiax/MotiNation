import 'dart:ui';
import 'package:motination/shared/constants.dart';
import 'package:flutter/material.dart';

import 'package:motination/services/auth.dart';

import 'package:motination/src/authentication/signIn.dart';
import 'package:motination/src/authentication/sendRegister.dart';
import 'package:motination/services/sharedPref.dart';

class SignUp extends StatefulWidget {
  @override
  createState() {
    return _SignUpState();
  }
}

class _SignUpState extends State<SignUp> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  final SharedPref _shared = SharedPref();
  // text field State
  String email = '';
  String password = '';
  String error = '';

  final barColor = const Color(0xFF0A79DF);

  Widget _registerButton() {
    return RawMaterialButton(
        constraints: BoxConstraints(minHeight: 60),
        fillColor: blue,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(color: blue)),
        onPressed: () async {
          try {
            if (_formKey.currentState.validate()) {
              setState(() => loading = true);
              dynamic result =
                  await _auth.registerWithEmailAndPassword(email, password);

              if (result == null) {
                setState(() {
                  error =
                      'Bitte geben Sie eine gülitig E-Mail Adresse/Passwort ein';
                  loading = false;
                });
              } else if (result == 'ERROR_EMAIL_ALREADY_IN_USE') {
                setState(() {
                  error = 'E-Mail bereits registriert';
                  loading = false;
                });
              } else {
                _shared.addIntToSP(intKey, 1);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SendRegister()));
              }
            }
          } catch (e) {
            print(e.toString());
            return null;
          }
        },
        child: Text("     Registrieren     ",
            style: Theme.of(context).textTheme.headline2));
  }

  Widget _registerField() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            TextFormField(
                decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    hintText: 'E-Mail'),
                validator: (val) => val.isEmpty ? 'Angaben benötigt' : null,
                onChanged: (val) {
                  setState(() => email = val);
                }),
            SizedBox(height: 20.0),
            TextFormField(
                decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    hintText: 'Neues Passwort'),
                obscureText: true,
                validator: (val) => val.length < 6 ? 'Angaben benötigt' : null,
                onChanged: (val) {
                  setState(() => password = val);
                }),
            SizedBox(height: 20.0),
            _registerButton(),
            SizedBox(height: 12.0),
            Text(
              error,
              style: TextStyle(color: Colors.red, fontSize: 14.0),
            ),
          ],
        ),
      ),
    );
  }

  Widget _signIn() {
    return RawMaterialButton(
        fillColor: bgColor,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SignIn()));
        },
        child: Text("       Zurück zum Login      "));
  }

  Widget build(context) {
    return new WillPopScope(
        onWillPop: () async => false,
        child: new Scaffold(
          backgroundColor: bgColor,
          body: Column(children: [
            Column(
              children: [
                Container(
                  height: 90,
                ),
                Container(
                  child: Center(
                    child: Text(
                      'Willkommen bei Motination!',
                      style: Theme.of(context).textTheme.headline1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Container(
                  height: 90,
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      'Lieblingssport machen, Punkte in Running oder Workout sammeln und coole Prämien absahnen',
                      style: Theme.of(context).textTheme.bodyText1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Container(
                  height: 90,
                ),
                Container(
                  child: Center(
                    child: Text(
                      'Jetzt registrieren:',
                      style: Theme.of(context).textTheme.headline1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                _registerField(),
                _signIn(),
              ],
            ),
          ]),
        ));
  }
}
