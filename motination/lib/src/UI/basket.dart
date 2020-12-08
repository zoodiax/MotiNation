import 'shop.dart';
import 'package:motination/src/UI/OldButGold/challenge.dart';
import 'package:motination/src/UI/profile.dart';
import 'package:flutter/material.dart';
import 'package:motination/src/UI/homescreen.dart';






class Basket extends StatefulWidget {

  @override

  createState() {

    return BasketState();

  }

}

class BasketState extends State<Basket> {

  int _currentIndex = 3;

    final barColor = const Color(0xFF0A79DF);

  final bgColor = const Color(0xFFFEFDFD);

  List picked = [false, false];



  int totalAmount = 0;



  pickToggle(index) {

    setState(() {

      picked[index] = !picked[index];

      getTotalAmount();

    });

  }



  getTotalAmount() {

    var count = 0;

    for (int i = 0; i < picked.length; i++) {

      if (picked[i]) {

        count = count + 1;

      }

      if (i == picked.length - 1) {

        setState(() {

          totalAmount = 248 * count;

        });

      }

    }

  }



  @override

  Widget build(BuildContext context) {

    var raisedButton = RaisedButton(

                              onPressed: () {},

                              elevation: 0.5,

                              color: Colors.blue,

                              child: Center(

                                child: Text(

                                  'Jetzt Punkte einlösen',

                                ),

                              ),

                              textColor: Colors.white,
                              

                            );
    return Scaffold(

      body: ListView(shrinkWrap: true, children: <Widget>[

        Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[

          Stack(children: [

            Stack(children: <Widget>[

              Container(

                height: MediaQuery.of(context).size.height,

                width: double.infinity,

              ),

              Container(

                height: 250.0,

                width: double.infinity,

                color: Color(0xFF0A79DF),

              ),

              Positioned(

                bottom: 450.0,

                right: 100.0,

                child: Container(

                  height: 400.0,

                  width: 400.0,

                  decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(200.0),

                    color: Color(0xFF0A79DF),

                  ),

                ),

              ),

              Positioned(

                bottom: 500.0,

                left: 150.0,

                child: Container(

                    height: 300.0,

                    width: 300.0,

                    decoration: BoxDecoration(

                        borderRadius: BorderRadius.circular(150.0),

                        color: Color(0xFF28CCD3))),

                        

              ),

              Padding(

                padding: EdgeInsets.only(top: 15.0),

                

              ),

              Positioned(

                  top: 75.0,

                  right: 15.0,

                  child: Text(

                    'Shopping Cart',

                    style: TextStyle(

                        fontFamily: 'Montserrat',

                        fontSize: 30.0,

                        color: bgColor,

                        fontWeight: FontWeight.bold),

                  )),

              Positioned(

                top: 150.0,

                child: Column(

                  children: <Widget>[

                    itemCard('Boulderwelt Regensburg', '10',

                        'assets/boulderwelt.jpg'),

                    itemCard('Boulderwelt Regensburg', '10',

                        'assets/boulderwelt.jpg'),

                    itemCard('Decathlon', '10',

                        'assets/decathlon.jpg')

                  ],

                ),

              ),

              Padding(

                  padding: EdgeInsets.only(top: 600.0, bottom: 15.0),

                  child: Container(

                      height: 50.0,

                      width: double.infinity,

                      color: Colors.white,

                      

                      child: Row(

                        mainAxisAlignment: MainAxisAlignment.end,

                        children: <Widget>[

                          Text('Total: ' + totalAmount.toString() + ' Punkte',
                          
                          style: TextStyle(

                                    fontFamily: 'Montserrat',

                                    fontWeight: FontWeight.bold,

                                    fontSize: 15.0),),



                          SizedBox(width: 10.0),

                          Padding(

                            padding: const EdgeInsets.all(8.0),

                            child: raisedButton,

                          )

                        ],

                      )))

            ])

          ])

        ])

      ]),

     bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            backgroundColor: bgColor,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat),
                label: 'Challenge',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_basket),
                label: 'Shop',
              ),
            ],
            onTap: (index) {
              setState(() {
                _currentIndex = index;
                if (_currentIndex == 3)
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Shoping()),
                  );
                if (_currentIndex == 2)
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Challenge()),
                  );
                   if (_currentIndex == 1)
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                if (_currentIndex == 0)
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Profile()),
                  );
              });
            },
          ),

    );

  }



  Widget itemCard(itemName, price, imgPath) {

    return InkWell(

      onTap: () {

       

      },

      child: Padding(

          padding: EdgeInsets.all(10.0),

          child: Material(

              borderRadius: BorderRadius.circular(10.0),

              elevation: 3.0,

              child: Container(

                  padding: EdgeInsets.only(left: 15.0, right: 10.0),

                  width: MediaQuery.of(context).size.width - 20.0,

                  height: 150.0,

                  decoration: BoxDecoration(

                      color: Colors.white,

                      borderRadius: BorderRadius.circular(10.0)),

                  child: Row(

                    children: <Widget>[

                      Column(

                        mainAxisAlignment: MainAxisAlignment.center,

                        children: <Widget>[

                          Container(

                              height: 25.0,

                              width: 25.0,

                             

                              child: Center(

                                  
                                      ))

                        ],

                      ),

                      SizedBox(width: 10.0),

                      Container(

                        height: 150.0,

                        width: 125.0,

                        decoration: BoxDecoration(

                            image: DecorationImage(

                                image: AssetImage(imgPath),

                                fit: BoxFit.contain)),

                      ),

                      SizedBox(width: 4.0),

                      Column(

                        mainAxisAlignment: MainAxisAlignment.center,

                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: <Widget>[

                          Row(

                            children: <Widget>[

                              Text(

                                itemName,

                                style: TextStyle(

                                    fontFamily: 'Montserrat',

                                    fontWeight: FontWeight.bold,

                                    fontSize: 15.0),

                              ),

                              SizedBox(width: 7.0),

                              

                                     

                                  

                            ],

                          ),

                          SizedBox(height: 7.0),

                         

                              

                                 

                                

                          SizedBox(height: 7.0),

                          

                               Text(

                                  price + ' Punkte',

                                  style: TextStyle(

                                      fontFamily: 'Montserrat',

                                      fontWeight: FontWeight.bold,

                                      fontSize: 20.0,

                                      color: Color(0xFF0A79DF)),

                                )

                              

                        ],

                      )

                    ],

                  )))),

    );
  }

}