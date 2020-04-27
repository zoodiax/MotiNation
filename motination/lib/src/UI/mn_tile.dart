import 'package:flutter/material.dart';
import 'package:motination/models/motination.dart';

class MNTile extends StatelessWidget {

  final MotiNation motiNation;
  MNTile({this.motiNation});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          title: Text(motiNation.name),
          subtitle: Text('Geben Sie Ihren vollständigen Namen ein:${motiNation.punkte} ${motiNation.alter}'),
        ),
      )
    );
  }
}