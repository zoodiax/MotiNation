
import 'package:flutter/material.dart';

import 'package:motination/src/UI/categorycard.dart';
import 'package:motination/src/UI/searchbar.dart';
import 'package:motination/src/UI/shop.dart';
import 'package:motination/src/UI/Run/running.dart';

class Dashboard extends StatefulWidget {

  @override

  
  createState() {

    return DashboardState();

  }

}


class DashboardState extends State<Dashboard> {

  String benutzername;

  

  Widget build(BuildContext context) {

    var size = MediaQuery.of(context)

        .size; //this gonna give us total height and with of our device

    return Scaffold(

      
      body: Stack(

        children: <Widget>[

          Container(

            // Here the height of the container is 45% of our total height

            height: size.height * .45,

            decoration: BoxDecoration(

              color: Color(0xFFff9a00),

             // image: DecorationImage(

             //   alignment: Alignment.centerLeft,

             //   image: AssetImage("assets/images/undraw_pilates_gpdb.png"),

            //  ),

            ),

          ),

          SafeArea(

            child: Padding(

              padding: const EdgeInsets.symmetric(horizontal: 20),

              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,

                children: <Widget>[

                
                  Text(

                    "Hi Sportsfreund*in \nSponi",

                    style: Theme.of(context)

                        .textTheme

                        .headline6


                  ),

                  SearchBar(),

                  Expanded(

                    child: GridView.count(

                      crossAxisCount: 2,

                      childAspectRatio: .85,

                      crossAxisSpacing: 20,

                      mainAxisSpacing: 20,

                      children: <Widget>[

                        CategoryCard(

                          title: "Shop News",

                         // icon: "assests/laufundberg.jpg",

                          press: () {Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Shoping()),
          );},

                        ),

                        CategoryCard(

                          title: "zu deinem Profil",

                          //svgSrc: "assests/laufundberg.jpg",

                          press: () {},

                        ),

                        CategoryCard(

                          title: "Folge uns auf Instagram!",

                         // svgSrc: 'assests/instagram.bmp',

                          press: () {

                           Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Running()),
                            );

                            

                          },

                        ),

                        CategoryCard(

                          title: "Sammle deine nächsten Punkte",

                         // Image.asset("assets/laufundberg.jpg"),

                          press: () {Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Running()),
          );},

                        ),

                      ],

                    ),

                  ),

                ],

              ),

            ),

          )

        ],

      ),

    );

  }

}