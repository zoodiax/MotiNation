import 'dart:ui';
import 'package:motination/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:motination/src/authentication/signIn.dart';
class SendRegister extends StatefulWidget {

  @override
  _SendRegisterState createState() => _SendRegisterState();
}

class _SendRegisterState extends State<SendRegister> {


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
            // Expanded(
            //   flex: 10,
            //   child:
            Column(
              children: [
                Container(
                  height: 90,
                ),

                //Spacer(flex: 4),
                Container(
                  child: Center(
                    child: Text(
                      'Erfolgreich registriert',
                      style: Theme.of(context).textTheme.headline1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Container(
                  height: 90,
                ),
                //Spacer(),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      'Wir haben dir eine E-Mail gesendet. Folge dem Link und aktiviere dein Konto!',
                      style: Theme.of(context).textTheme.bodyText1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Container(
                  height: 90,
                ),
                //Spacer(flex: 2),
                
                _signIn(),
              ],
            ),
           
          ]),
        ));
  }
}