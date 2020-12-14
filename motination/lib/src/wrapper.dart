import 'package:flutter/material.dart';
import 'package:motination/models/user.dart';
import 'package:provider/provider.dart';
import 'UI/homescreen.dart';
//import 'authentication/authenticate.dart';
import 'authentication/signIn.dart';
import 'package:motination/src/authentication/firstTime.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    
    return FirstTime();
    //return either Home or SignIn widget
    if (user == null) {
      
      return SignIn(); 
    } else {
      return HomeScreen();
    }

  }
}