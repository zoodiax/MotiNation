import 'dart:ui';
import 'package:motination/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:motination/src/authentication/signIn.dart';


class SendPW extends StatefulWidget {

  @override
  _SendPWState createState() => _SendPWState();
}

class _SendPWState extends State<SendPW> {


Widget _signIn(){
  return RawMaterialButton(
        constraints: BoxConstraints(minHeight: 60),
        fillColor: blue,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(color: blue)),
        onPressed: () async {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => SignIn()));
        },
        child: Text("     Zum Login     ",
            style: Theme.of(context).textTheme.headline2));}

  @override
  Widget build(BuildContext context) {
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
                      'Passwort zurückgesetzt',
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
                      'Wir haben dir eine E-Mail gesendet. Folge dem Link und erneuere dein Passwort!',
                      style: Theme.of(context).textTheme.bodyText1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Container(
                  height: 90,
                ),
                _signIn(),
              ],
            ),
           
          ]),
        ));
  }
}