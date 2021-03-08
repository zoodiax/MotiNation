import 'package:flutter/material.dart';

import 'package:motination/shared/constants.dart';


 class CustomAppBar extends PreferredSize {
  final Widget child;
  final double height;
  final String name;

  CustomAppBar({this.child, @required this.name, this.height = kToolbarHeight});

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(name ,style:  Theme.of(context).textTheme.headline1),
       backgroundColor: bgColor,
     
    );
    
  }
}