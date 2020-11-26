import 'package:flutter/material.dart';


/*

  Sports Center Prototype UI Class - used for Firebase on ListView (Workout Function)
  Goal: get also the information for the marker from MapView(Workout FUnction) connected with Class SpzInfo via Firebase
*/
 
class SpzInfo extends StatelessWidget {
  SpzInfo({
    this.infotitle = 'Name',
    this.infoopenhrs = 'Hier stehen die Öffnungszeiten',
    this.infoaddress = 'Hier steht die Adresse',
    this.infotext = 'Hier gibt es die Informationen über das Sportzentrum',
    this.infospecial =
        'Hier stehen Aktionen, falls das Sportzentrum Premium Partner ist',
    this.infocategory = 'Fitness Kategorie',
    this.infolat,
    this.infolng,
  });
  final String infotitle;
  final String infoopenhrs;
  final String infoaddress;
  final String infospecial;
  final String infotext;
  final String infocategory;
  final String infolat;
  final String infolng;

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(infotitle),
      ),
      body: Center(
        child: Card(
            child: Column(children: [
          Icon(Icons.fitness_center),
          ListTile(
            title: Text(infocategory),
            subtitle: Text(infotext),
          ),
          Divider(),
          ListTile(
            title: Text('Öffnungszeiten:'),
            subtitle: Text(infoopenhrs),
          ),
          Divider(),
          ListTile(
            title: Text('Adresse'),
            subtitle: Text(infoaddress),
          ),
          Divider(),
          ListTile(title: Text('Aktion'), subtitle: Text(infospecial)),
        ])),
      ),
    );
  }
}