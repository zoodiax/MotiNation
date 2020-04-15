import 'package:flutter/material.dart';
import 'package:motination/models/user.dart';
import 'package:provider/provider.dart';
import 'UI/homescreen.dart';
import 'authentication/authenticate.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    

    //reutrn either Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return HomeScreen();
    }

  }
}