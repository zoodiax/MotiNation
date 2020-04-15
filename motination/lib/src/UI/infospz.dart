import 'package:flutter/material.dart';


class Infospz extends StatelessWidget {
  Infospz({
    this.infotitle,
    this.infoopenhrs = 'Hier stehen die Öffnungszeiten',
    this.infoaddress = 'Hier steht die Adresse',
    this.infoname = 'Hier gibt es die Informationen über das Sportzentrum',
    this.infospecial =
        'Hier stehen Aktionen, falls das Sportzentrum Premium Partner ist',
  });
  final String infotitle;
  final String infoopenhrs;
  final String infoaddress;
  final String infospecial;
  final String infoname;
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Sportzentrum'),
      ),
      body: Center(
        child: Card(
            child: Column(children: [
          Icon(Icons.fitness_center),
          ListTile(
            title: Text(infotitle),
            subtitle: Text(infoname),
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

class InfoHallenbad extends StatelessWidget {
  InfoHallenbad({
    this.infotitle = 'Name',
    this.infoopenhrs = 'Hier stehen die Öffnungszeiten',
    this.infoaddress = 'Hier steht die Adresse',
    this.infoname = 'Hier gibt es die Informationen über das Sportzentrum',
    this.infospecial =
        'Hier stehen Aktionen, falls das Sportzentrum Premium Partner ist',
  });
  final String infotitle;
  final String infoopenhrs;
  final String infoaddress;
  final String infospecial;
  final String infoname;
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Sportzentrum'),
      ),
      body: Center(
        child: Card(
            child: Column(children: [
          Icon(Icons.pool),
          ListTile(
            title: Text('das Stadtwerk.Hallenbad'),
            subtitle: Text(infoname),
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

class InfoFitnessFirst extends StatelessWidget {
  InfoFitnessFirst({
    this.infotitle = 'Name',
    this.infoopenhrs = 'Hier stehen die Öffnungszeiten',
    this.infoaddress = 'Hier steht die Adresse',
    this.infoname = 'Hier gibt es die Informationen über das Sportzentrum',
    this.infospecial =
        'Hier stehen Aktionen, falls das Sportzentrum Premium Partner ist',
  });
  final String infotitle;
  final String infoopenhrs;
  final String infoaddress;
  final String infospecial;
  final String infoname;
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Sportzentrum'),
      ),
      body: Center(
        child: Card(
            child: Column(children: [
          Icon(Icons.fitness_center),
          ListTile(
            title: Text('Fitness First'),
            subtitle: Text(infoname),
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

class InfoUnisport extends StatelessWidget {
  InfoUnisport({
    this.infotitle = 'Name',
    this.infoopenhrs = 'Hier stehen die Öffnungszeiten',
    this.infoaddress = 'Hier steht die Adresse',
    this.infoname = 'Hier gibt es die Informationen über das Sportzentrum',
    this.infospecial =
        'Hier stehen Aktionen, falls das Sportzentrum Premium Partner ist',
  });
  final String infotitle;
  final String infoopenhrs;
  final String infoaddress;
  final String infospecial;
  final String infoname;
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Sportzentrum'),
      ),
      body: Center(
        child: Card(
            child: Column(children: [
          Icon(Icons.fitness_center),
          ListTile(
            title: Text('Unisport'),
            subtitle: Text(infoname),
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

class InfoWoehrdbad extends StatelessWidget {
  InfoWoehrdbad({
    this.infotitle = 'Name',
    this.infoopenhrs = 'Hier stehen die Öffnungszeiten',
    this.infoaddress = 'Hier steht die Adresse',
    this.infoname = 'Hier gibt es die Informationen über das Sportzentrum',
    this.infospecial = 'Hier stehen Aktionen, falls das Sportzentrum Premium Partner ist',
  });
  final String infotitle;
  final String infoopenhrs;
  final String infoaddress;
  final String infospecial;
  final String infoname;
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Sportzentrum'),
      ),
      body: Center(
        child: Card(
            child: Column(children: [
          Icon(Icons.pool),
          ListTile(
            title: Text('dasStadtwerk.Wöhrdbad'),
            subtitle: Text(infoname),
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

class InfoWestbad extends StatelessWidget {
  InfoWestbad({
    this.infotitle = 'Name',
    this.infoopenhrs = 'Hier stehen die Öffnungszeiten',
    this.infoaddress = 'Hier steht die Adresse',
    this.infoname = 'Hier gibt es die Informationen über das Sportzentrum',
    this.infospecial = 'Hier stehen Aktionen, falls das Sportzentrum Premium Partner ist',
  });
  final String infotitle;
  final String infoopenhrs;
  final String infoaddress;
  final String infospecial;
  final String infoname;
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Sportzentrum'),
      ),
      body: Center(
        child: Card(
            child: Column(children: [
          Icon(Icons.pool),
          ListTile(
            title: Text('dasStadtwerk.Westbad'),
            subtitle: Text(infoname),
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
