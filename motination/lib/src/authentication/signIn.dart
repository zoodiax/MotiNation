import 'dart:ui';
import 'package:motination/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:motination/src/UI/Run/running.dart';
import 'package:motination/services/auth.dart';
import 'package:motination/src/authentication/forgotPw.dart';
import 'package:motination/src/authentication/signUp.dart';
import 'package:motination/services/sharedPref.dart';
import 'package:motination/src/authentication/firstTime.dart';


class SignIn extends StatefulWidget {
  @override
  createState() {
    return _SignInState();
  }
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final SharedPref _shared = SharedPref();
  bool loading = false;

  // text field State
  String email = '';
  String password = '';
  String error = '';

  final barColor = const Color(0xFF0A79DF);

  Widget _loginButton() {
    return RawMaterialButton(
        constraints: BoxConstraints(minHeight: 60),
        fillColor: blue,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(color: blue)),
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            setState(() => loading = true);
            dynamic result =
                await _auth.signInrWithEmailAndPassword(email, password);
            if (result == null) {
              setState(() {
                error =
                    'Bitte geben Sie eine gülitig E-Mail Adresse/Passwort ein';
                loading = false;
              });
            } else {
              int flag = await _shared.getIntValuesSP(intKey);
              print('Flag Sign In: $flag');
              if(flag == 1) 
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => FirstTime()));
              else 
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Running()));
            }
          }
        },
        child: Text("     Einloggen     ",
            style: Theme.of(context).textTheme.headline2));
  }



  Widget _loginField() {
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
                    hintText: 'Passwort'),
                obscureText: true,
                validator: (val){
                  if(val.length ==  0) return 'Angaben benötig';
                  else if (val.length < 6) return 'Passwort zu kurz';
                  else return null; },//tval.length < 6 ? 'Angaben benötigt' : null} ,
                onChanged: (val) {
                  setState(() => password = val);
                }),
            SizedBox(height: 20.0),
            _loginButton(),
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

  Widget _forgotPW() {
    return RawMaterialButton(
        fillColor: bgColor,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ForgotPW()));
        },
        child: Text("     Passwort vergessen     "));
  }

  Widget _register() {
    return RawMaterialButton(
        fillColor: bgColor,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
      
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SignUp()));
        },
        child: Text("         Jetzt registrieren        "));
  }



  Widget build(context){
    
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
                      'Anmelden:',
                      style: Theme.of(context).textTheme.headline1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                _loginField(),
                _forgotPW(),
                _register(),
              ],
            ),
          ]),
        ));
  }
}
