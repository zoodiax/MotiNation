import 'package:flutter/material.dart';
import 'package:motination/models/user.dart';
import 'package:motination/services/auth.dart';
import 'package:provider/provider.dart';
import 'src/wrapper.dart';
import 'package:motination/shared/theme.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      
      value: AuthService().user,
      child: MaterialApp(
        theme: getTheme(),
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}
