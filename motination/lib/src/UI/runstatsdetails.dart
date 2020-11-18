import 'package:flutter/material.dart';

class RunStatsDetails extends StatelessWidget {
  RunStatsDetails({this.currentdistanz = '0',this.currentdate ='0'});
  final currentdistanz;
  final currentdate;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lauf/Fahrradfahren vom:' + currentdate)
      ),
      body: /*Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          /*Expanded(
            child: Image(
              image: NetworkImage('https://media-exp1.licdn.com/dms/image/C4D03AQG3wibhAzXXCA/profile-displayphoto-shrink_800_800/0?e=1610582400&v=beta&t=_0g4xt4l8w_t0issy2U_SXB9DWwnVVKpnIwPJYoqJ_8'),
            ))*/*/
          GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            padding: const EdgeInsets.all(20),
            children: <Widget>[
              Center(
              child: Container(
                height: 175,
                width: 175,
                color: Colors.blue[100],
                padding: const EdgeInsets.all(30),
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.alt_route,
                      color: Colors.blueGrey,
                      size: 75,
                    ),
                    //Spacer(),
                    Text(
                      currentdistanz,
                      style: TextStyle(fontStyle: FontStyle.normal, fontWeight: FontWeight.bold, fontSize: 30),
                      ),
                  ],
                ),
              ),
              ),
              Center(
                child: Container(
                  height: 175,
                  width: 175,
                  color: Colors.blueAccent[100],
                  padding: const EdgeInsets.all(30),
                  child:Column(
                    children: <Widget>[
                      Icon(
                        
                        Icons.alt_route_rounded,
                        color: Colors.blueGrey,
                        size: 75,
                      ),
                      Spacer(),
                      Text(
                        currentdistanz,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                      ),
                  ],
                ),
              ),
              ),
              Center(
                child: Container(
                  height: 175,
                  width: 175,
                  color: Colors.blueAccent[100],
                  padding: const EdgeInsets.all(30),
                  child:Column(
                    children: <Widget>[
                      Icon(
                        Icons.alt_route_rounded,
                        color: Colors.blueGrey,
                        size: 75,
                      ),
                      Spacer(),
                      Text(
                        currentdistanz,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                      ),
                  ],
                ),
              ),
              ),
              Center(
                child: Container(
                  width: 175,
                  height: 175,
                  color: Colors.blueAccent[200],
                  padding: const EdgeInsets.all(30),
                  child:Column(
                    children: <Widget>[
                      Icon(
                        Icons.alt_route_rounded,
                        color: Colors.blueGrey,
                        size: 75,
                      ),
                      Spacer(),
                      Text(
                        currentdistanz,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                      ),
                  ],
                ),
              ),
              ),
              Center(
                child: Container(
                  width:175,
                  height: 175,
                  color: Colors.blueAccent[200],
                  padding: const EdgeInsets.all(30),
                  child:Column(
                    children: <Widget>[
                      Icon(
                        Icons.alt_route_rounded,
                        color: Colors.blueGrey,
                        size: 75,
                      ),
                      Spacer(),
                      Text(
                        currentdistanz,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                      ),
                  ],
                ),
              ),
              ),
              Center(
                child: Container(
                  
                  //decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                  height: 175,
                  width: 175,
                  color: Colors.blue[200],
                  padding: const EdgeInsets.all(30),
                  child:Column(
                    children: <Widget>[
                      Icon(
                        Icons.alt_route_rounded,
                        color: Colors.black,
                        size: 75,
                      ),
                      Spacer(),
                      Text(
                        currentdistanz,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                      ),
                  ],
                ),
              ),
              ),
                                                                      
            ],
            )
        //],
      //),
      
    );
  }
}