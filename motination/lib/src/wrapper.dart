import 'package:flutter/material.dart';
import 'package:motination/models/user.dart';
import 'package:provider/provider.dart';
import 'UI/homescreen.dart';
//import 'authentication/authenticate.dart';
import 'authentication/signIn.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    

    //reutrn either Home or Authenticate widget
    if (user == null) {
      //return Authenticate();
      return SignIn();
    } else {
      return HomeScreen();
    }

  }
}