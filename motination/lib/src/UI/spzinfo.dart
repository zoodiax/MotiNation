import 'package:flutter/material.dart';
import 'package:motination/shared/constants.dart';

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
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(infotitle, style:  Theme.of(context).textTheme.headline1,),
            backgroundColor: bgColor,),
      
      body: Center(
        child: Card(
            child: Column(children: [
          Spacer(),
          Icon(Icons.fitness_center),
          Spacer(),
          ListTile(
            title: Text(infocategory,style: Theme.of(context).textTheme.headline5,),
            subtitle: Text(infotext,style: Theme.of(context).textTheme.bodyText2,),
          ),
          Divider(),
          ListTile(
            title: Text('Öffnungszeiten:',style: Theme.of(context).textTheme.headline5,),
            subtitle: Text(infoopenhrs,style: Theme.of(context).textTheme.bodyText2,),
          ),
          Divider(),
          ListTile(
            title: Text('Adresse',style: Theme.of(context).textTheme.headline5,),
            subtitle: Text(infoaddress,style: Theme.of(context).textTheme.bodyText2,),
          ),
          Divider(),
          ListTile(title: Text('Aktion',style: Theme.of(context).textTheme.headline5,),
           subtitle: Text(infospecial,style: Theme.of(context).textTheme.bodyText2,)),
           Spacer(),
        ])),
      ),
    );
  }
}