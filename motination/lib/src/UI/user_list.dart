// import 'package:flutter/material.dart';
// import 'package:motination/models/motination.dart';
// import 'package:motination/src/UI/mn_tile.dart';
// import 'package:provider/provider.dart';

// class UserList extends StatefulWidget {
//   @override
//   _UserListState createState() => _UserListState();
// }

// class _UserListState extends State<UserList> {
//   @override

//   Widget build(BuildContext context) {

//       final mNUser = Provider.of<List<MotiNation>>(context);
   

//     return ListView.builder(
//       itemCount: mNUser.length,
//       itemBuilder: (context, index) {
//         return MNTile(motiNation: mNUser[index]);
//       },
//     ); 
      
    
//   }
// }