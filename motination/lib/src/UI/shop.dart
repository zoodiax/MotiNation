import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:motination/models/user.dart';
import 'package:motination/src/UI/basket.dart';
import 'package:motination/src/UI/profile.dart';
import 'package:motination/src/UI/challenge.dart';
import 'package:provider/provider.dart';
import 'package:motination/src/UI/homescreen.dart';
import 'package:motination/models/shop.dart';







class Shoping extends StatefulWidget {



  @override



  createState() {

    return ShopState();

  }

}


class ShopState extends State<Shoping> {

 int _currentIndex = 3;

 
  final wrktColor = const Color(0xFF28CCD3);
  final blackColor = const Color(0xBF000000);

  final barColor = const Color(0xFF0A79DF);

  final bgColor = const Color(0xFFFEFDFD);

 var selectedItem = 'All products';





  Widget build(context) {

    //Shop shop = Provider.of<Shop>(context);
      
    var children2 = <Widget>[





                           
                                  
                               

  
                            
                                    
                            
    

  


                _buildShopItem('assets/bergundlauf.png', 'Berg und Lauf König', 'Voucher', '10.00'),


                _buildShopItem('assets/boulderwelt.jpg', 'Boulderwelt Regensburg', 'Voucher', '10.00'),
                _buildShopItem('assets/decathlon.jpg', 'Decathlon', 'Voucher', '20.00'),
                _buildShopItem('assets/tarayoga.jpg', 'Tarayoga', 'Discount', '10 % auf 10er Karte') 
                
                ];


   
    return Scaffold(

      backgroundColor: bgColor,

      appBar: AppBar(

        title: Text('Shop'),

        

        backgroundColor: barColor,

       

      ),

      bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            backgroundColor: bgColor,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                title: Text('Profile'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text('Home'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat),
                title: Text('Challenge'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_basket),
                title: Text('Shop'),
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

      body:      ListView(
      children: <Widget>[
      
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 15.0),
              
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0, right: 15.0),
              child: Stack(
                children: <Widget>[
                  Container(
                    height: 50.0,
                    width: 50.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.transparent),
                  ),
                  Container(
                    height: 40.0,
                    width: 40.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Color(0xFF0A79DF)),
                    child: Center(
                      child: 

                      FlatButton.icon(
                icon: Icon(
                  Icons.shopping_basket,
                  color: Colors.white,
                  size: 20.0,
                ),
                label: Text(
                  'shopping cart',
                  style: TextStyle(color: bgColor),
                ),
                onPressed: () 
                {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Basket()),
                        );
                      },
              )
                        
                      ),
                    ),
                 // ),
                  Positioned(

                    top: 25.0,

                    right: 30.0,

                    child: Container(

                      height: 20.0,

                      width: 20.0,

                      decoration: BoxDecoration(

                          borderRadius: BorderRadius.circular(10.0),

                          color: Colors.red),

                      child: Center(

                          child: Text(

                        '8',

                        style: TextStyle(

                            fontFamily: 'Raleway', color: Colors.white),
                      )),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.all(15.0),
          child: Text(
            'Belohne dich mit tollen Preisen!',
            style: TextStyle(
                fontFamily: 'Raleway',
                fontSize: 22.0,
                fontWeight: FontWeight.bold),
          ),
        
        ),
        Padding(
          padding: EdgeInsets.only(left: 15.0, top: 15.0, bottom: 15.0),
          child: Container(
            height: 100.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                _buildItem('All products', 4),
                _buildItem('Voucher', 3),
                _buildItem('Gift', 0),
                _buildItem('Discount', 1),
                ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 15.0, top: 15.0, bottom: 10.0),
          child: Container(
            height: MediaQuery.of(context).size.height - 300.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              
              children: children2,
              
            ),
          ),
        ),
      ],
    ));
  }

  _buildShopItem(String imgPath, String productName, String productType, String price) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Container(
        width: 225.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 4.0,
              blurRadius: 4.0
            )
          ]
        ),
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 200.0,
                  width: 225.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
                    image: DecorationImage(
                      image: AssetImage(imgPath),
                      fit: BoxFit.cover
                    )
                  ),
                ),
                SizedBox(height: 25.0),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(productName,
                  style: TextStyle(
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0
                  ),
                  ),
                ),
                SizedBox(height: 5.0),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(productType,
                  style: TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: 14.0,
                    color: Colors.grey
                  ),
                  ),
                ),
                SizedBox(height: 15.0),
                Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Container(
                    height: 0.4,
                    color: Colors.grey.withOpacity(0.4),
                  )
                ),
                SizedBox(height: 15.0),
                Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                         price + 'Punkte',
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.bold,
                          fontSize: 19.0
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          height: 40.0,
                          width: 40.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Colors.grey.withOpacity(0.2)
                          ),
                          child: Center(
                            child: Icon(
                              Icons.add,
                              color: Colors.grey
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        )
      ),
    );
  }

  _buildItem(String productName, int count) {
    return Padding(
      padding: EdgeInsets.only(right: 15.0, top: 10.0, bottom: 10.0, left: 4.0),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeIn,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: switchHighlight(productName),
            boxShadow: [
              BoxShadow(
                  blurRadius: 4.0,
                  spreadRadius: 2.0,
                  color: switchShadow(productName))
            ]),
        height: 50.0,
        width: 125.0,
        child: InkWell(
          onTap: () {
            selectedProduct(productName);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10.0),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  count.toString(),
                  style: TextStyle(
                      fontFamily: 'Raleway',
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                      color: switchHighlightColor(productName)),
                ),
              ),
              SizedBox(height: 7.0),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  productName,
                  style: TextStyle(
                      fontFamily: 'Raleway',
                      fontSize: 15.0,
                      color: switchHighlightColor(productName)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  selectedProduct(prodName) {
    setState(() {
      selectedItem = prodName;
   });
  }

  switchHighlight(prodName) {
    if (prodName == selectedItem) {
      return Color(0xFF0A79DF);
    } else {
      return Colors.grey.withOpacity(0.3);
    }
  }

  switchHighlightColor(prodName) {
    if (prodName == selectedItem) {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }

  switchShadow(prodName) {
    if (prodName == selectedItem) {
      return Color(0xFF0A79DF).withOpacity(0.4);
    } else {
      return Colors.transparent;
    }
  }
}



        





  




  