import 'package:flutter/material.dart';
import 'package:motination/models/user.dart';
import 'package:provider/provider.dart';
import 'UI/homescreen.dart';
import 'authentication/signIn.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    
    //return either Home or SignIn widget
    if (user == null) {
      
      return SignIn(); 
    } else {
      return HomeScreen();
    }

  }
}