import 'dart:ui';
import 'package:motination/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:motination/services/auth.dart';
import 'package:motination/src/authentication/signIn.dart';
import 'package:motination/src/authentication/sendPW.dart';
import 'package:motination/src/authentication/signUp.dart';


class ForgotPW extends StatefulWidget {
  @override
  createState() {
    return _ForgotPWState();
  }
}

class _ForgotPWState extends State<ForgotPW> {
  final AuthService _auth = AuthService();
  
  bool loading = false;

  // text field State
  String email = '';

  String error = '';

  final barColor = const Color(0xFF0A79DF);

  Widget _sendNewPW() {
    return RawMaterialButton(
        constraints: BoxConstraints(minHeight: 60),
        fillColor: blue,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(color: blue)),
        onPressed: () async {
            
            setState(() => loading = true);
            try{await _auth.resetPassword(email);
            print('Email send to $email');
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => SendPW()));
            } catch(e){
              setState(() {
                loading = false;
                error = 'Registrierte E-Mail eingeben oder jetzt registrieren';
                print(e.toString());
              });
            }
            
    
        },
        child: Text("     Absenden     ",
            style: Theme.of(context).textTheme.headline2));
  }

  Widget _newPasswordField() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
      child: Form(
        
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
            //     }),
            SizedBox(height: 20.0),
            _sendNewPW(),
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

  Widget _signIn(){
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
                      'Passwort vergessen?',
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
                      'Gib hier deine Motination E-Mail Adresse an und wir schicken dir ein neues Passwort',
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
                      'Deine E-Mail:',
                      style: Theme.of(context).textTheme.headline1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                _newPasswordField(),
                _signIn(),
                _register(),
              ],
            ),
          ]),
        ));
  }
}
