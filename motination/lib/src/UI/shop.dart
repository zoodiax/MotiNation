import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:motination/src/UI/basket.dart';
import 'package:motination/src/UI/OldButGold/points.dart';
import 'package:motination/src/UI/profile.dart';
import 'package:motination/src/UI/OldButGold/challenge.dart';
import 'package:provider/provider.dart';
import 'package:motination/src/UI/homescreen.dart';
import 'package:motination/src/UI/shopitem.dart';
import 'package:motination/models/user.dart';
import 'package:motination/widgets/bottomBar.dart';




class Shoping extends StatefulWidget {



  @override
 


  createState() {

    return ShopState();

  }

}


class ShopState extends State<Shoping> {

int points = 1000;
 int _currentIndex = 3;



 
  final wrktColor = const Color(0xFF28CCD3);
  final blackColor = const Color(0xBF000000);

  final barColor = const Color(0xff191970); //final blue

  final bgColor = const Color(0xFFFEFDFD);

  
// wichtig: beim sortieren werden Klein/buchstaben berücksichtigt. zuerst alle kleinen, dann groß
  List<Shopitem> shopitemList = [
  Shopitem(
    1, "lauf und Berg König", "Voucher", 100, "10 €", "assets/laufundberg.jpg", "info"
  ),
  Shopitem(
    2, "decathlon", "Voucher", 200, "20 €", "assets/decathlon.jpg", "info"
  ),
  Shopitem(
    3, "boulderwelt", "Discount", 500, "10 % auf Jahreskarte", "assets/boulderwelt.jpg", "info"
  ),
];

List<Shopitem> basketList = [];
    

      






  @override

  Widget build(BuildContext context) {


    // MediaQuery to get Device Width

    double width = MediaQuery.of(context).size.width * 0.6;

     return Scaffold(

      //backgroundColor: bgColor,

     appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text('Shop' , style:  Theme.of(context).textTheme.headline1,),
            backgroundColor: bgColor,

            

            
          ),

      bottomNavigationBar: bottomBar(_currentIndex,context),


      // Main List View With Builder

      body:    
      Column(
    children: <Widget>[
     
          Row(
         // spacing: 8.0, // gap between adjacent chips
         // runSpacing: 4.0,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0, right: 10.0),
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
                        color: Color(0xff191970)),
                     child:  Flexible(
                     child: 

                     IconButton(
            icon: Icon(Icons.shopping_bag),
            color: Colors.white,
            
            
            onPressed: () { Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Basket(basketList: basketList, )),
     );
},

                     
              ) , 
                        
                      ),
                  
                    ),
               
                ],
              ),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.all(15.0),
          child: Text(
            'Belohne dich mit coolen Prämien!',
          
                style: Theme.of(context).textTheme.headline1,
          ),

             
        ),
Padding(
          padding: EdgeInsets.all(15.0),
          child: Text(
            

            'Dein Punktestand: ' + points.toString(), 
     
                style: Theme.of(context).textTheme.bodyText1,
          ),

          
        
        ),
  
      Padding(
          padding: EdgeInsets.only(left: 15.0, top: 15.0, bottom: 15.0),
          child: Container(
            height: 100.0,
            
            child: Align(

                    alignment: Alignment.center, 
              child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[

              
             Padding(
      padding: EdgeInsets.only(right: 15.0, top: 10.0, bottom: 10.0, left: 4.0),
      
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeIn,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Color(0xff191970),
            boxShadow: [
              BoxShadow(
                  blurRadius: 4.0,
                  spreadRadius: 2.0,
                  color: Color(0xff191970),)
            ]),
        height: 50.0,
        width: 125.0,
        child: InkWell(
          onTap: () {

            
            setState(() {
            shopitemList.sort((a, b) => a.name.toString().compareTo(b.name.toString()));
            });


            
           
          
            
          
            
            
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              
              
              
              SizedBox(height: 7.0, width: 7.0 ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),

                
                child: 
                Text(
                  "Alphabetisch",
                  style:Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.center,// TextStyle(
                      //fontFamily: 'Raleway',
                      //fontSize: 15.0,
                     // color: switchHighlightColor(productName)),
                ),
                

                

                
              ),  

              

                            
              
            ],
          ),
        ),
      ),
      
    ),

Padding(
      padding: EdgeInsets.only(right: 15.0, top: 10.0, bottom: 10.0, left: 4.0),
      
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeIn,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Color(0xff191970),
            boxShadow: [
              BoxShadow(
                  blurRadius: 4.0,
                  spreadRadius: 2.0,
                  color: Color(0xff191970),)
            ]),
        height: 50.0,
        width: 125.0,
        child: InkWell(
          onTap: () {

            
            setState(() {
            shopitemList.sort((b, a) => a.points.compareTo(b.points));
            });


            
           
          
            
          
            
            
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              
              
              
              SizedBox(height: 7.0, width: 7.0 ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: 
                Text(
                  "Punkte absteigend",
                  style:Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.center,// TextStyle(
                      //fontFamily: 'Raleway',
                      //fontSize: 15.0,
                     // color: switchHighlightColor(productName)),
                ),

                

                
              ),  

              

                            
              
            ],
          ),
        ),
      ),
      
    ),

    Padding(
      padding: EdgeInsets.only(right: 15.0, top: 10.0, bottom: 10.0, left: 4.0),
      
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeIn,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Color(0xff191970),
            boxShadow: [
              BoxShadow(
                  blurRadius: 4.0,
                  spreadRadius: 2.0,
                  color: Color(0xff191970),)
            ]),
        height: 50.0,
        width: 125.0,
        child: InkWell(
          onTap: () {

            
            setState(() {
            shopitemList.sort((a, b) => a.points.compareTo(b.points));
            });


            
           
          
            
          
            
            
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              
              
              
              SizedBox(height: 7.0, width: 7.0 ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: 
                Text(
                  "Punkte aufsteigend",
                  style:Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.center,// TextStyle(
                      //fontFamily: 'Raleway',
                      //fontSize: 15.0,
                     // color: switchHighlightColor(productName)),
                ),

                

                
              ),  

              

                            
              
            ],
          ),
        ),
      ),
      
    ),


     Padding(
      padding: EdgeInsets.only(right: 15.0, top: 10.0, bottom: 10.0, left: 4.0),
      
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeIn,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Color(0xff191970),
            boxShadow: [
              BoxShadow(
                  blurRadius: 4.0,
                  spreadRadius: 2.0,
                  color: Color(0xff191970),)
            ]),
        height: 50.0,
        width: 125.0,
        child: InkWell(
          onTap: () {

            
            setState(() {
            shopitemList.sort((a, b) => a.category.compareTo(b.category));
            });


            
           
          
            
          
            
            
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              
              
              
              SizedBox(height: 7.0, width: 7.0 ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: 
                Text(
                  "Kategorie",
                  style:Theme.of(context).textTheme.headline6,
                  // TextStyle(
                      //fontFamily: 'Raleway',
                      //fontSize: 15.0,
                     // color: switchHighlightColor(productName)),
                ),

                

                
              ),  

              

                            
              
            ],
          ),
        ),
      ),
      
    ),
    
               
                ],

                
            ),
            ),
          ),
        ),

        
      Padding(
          padding: EdgeInsets.only( top: 15.0, bottom: 15.0),
          child: Container(
            height: 270.0,
            
            child: Align(

                    alignment: Alignment.center, 
              child:  
       



        
         ListView.builder(

  

        itemCount: shopitemList.length,

        itemBuilder: (context, index) {

          return 
         
          
          GestureDetector(

            onTap: () {
              // This Will Call When User Click On ListView Item

              showDialogFunc(context, shopitemList[index].img, shopitemList[index].name, shopitemList[index].info);

            },

            

            // Card Which Holds Layout Of ListView Item

            child: Card(

              child: Row(

                children: <Widget>[

                  Container(

                    width: 80,

                    height: 100,

                    child: Image.asset(shopitemList[index].img),

                  ),

                  Padding(

                    padding: const EdgeInsets.all(10.0),

                    child: Column(

                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: <Widget>[

                        Text(

                          shopitemList[index].name,

                          style: TextStyle(

                            fontSize: 25,

                            color: Colors.grey,

                            fontWeight: FontWeight.bold,

                          ),

                        ),

                        SizedBox(

                          height: 10,

                        ),

                        Container(

                          width: width,

                          child: Text(

                            'Punkte ' + shopitemList[index].points.toString(),
                            

                            maxLines: 3,

                            style: TextStyle(

                                fontSize: 15, color: Colors.grey[500]),

                          ),

                          

                        ),

                        SizedBox(

                          height: 10,

                        ),

                        Container(

                          width: width,

                          child: Text(

                            'Kategorie: ' + shopitemList[index].category,
                            

                            maxLines: 3,

                            style: TextStyle(

                                fontSize: 15, color: Colors.grey[500]),

                          ),

                          

                        ),

                        SizedBox(

                          height: 10,

                        ),

                        Container(

                          width: width,

                          child: Text(

                            'Wert: ' + shopitemList[index].value.toString(),
                            

                            maxLines: 3,

                            style: TextStyle(

                                fontSize: 15, color: Colors.grey[500]),

                          ),

                          

                        ),


                           RaisedButton(
          onPressed: () async { 

           basketList.add( shopitemList[index]);
            setState(() {
             Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Basket(basketList: basketList,)),
     );


    });                          
                        
                          },
          color: Color(0xff191970),
          child: Icon((Icons.add),
            color: Colors.white,),
          
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(300)),
        ),

                      ],

                    ),

                  )

                ],

              ),

            ),

          );

        },

      ),

), 
     
       
          ),

      ),
    
    ],

    ),
     );

  }

}



// This is a block of Model Dialog 

showDialogFunc(context, img, title, desc) {

List<Shopitem> shopitemList = [
  Shopitem(
    1, "lauf und Berg König", "Voucher", 100, "10 €", "assets/laufundberg.jpg", "info"
  ),
  Shopitem(
    2, "decathlon", "Voucher", 200, "20 €", "assets/decathlon.jpg", "info"
  ),
  Shopitem(
    3, "boulderwelt", "Discount", 500, "10 % auf Jahreskarte", "assets/boulderwelt.jpg", "info"
  ),
];

  return showDialog(

    context: context,

    builder: (context) {

      return Center(

        child: Material(

          type: MaterialType.transparency,

          child: Container(
            
                     

            
                        
                      

            decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(10),

              color: Colors.white,

            ),

            padding: EdgeInsets.all(15),

            height: 450,

            width: MediaQuery.of(context).size.width * 0.7,

            child: Column(

              crossAxisAlignment: CrossAxisAlignment.center,

              children: <Widget>[

                ClipRRect(

                  borderRadius: BorderRadius.circular(5),

                  child: Image.asset(

                    img,

                    width: 200,

                    height: 200,

                  ),

                ),

                SizedBox(

                  height: 10,

                ),

                Text(

                  title,

                  style: TextStyle(

                    fontSize: 25,

                    color: Colors.grey,

                    fontWeight: FontWeight.bold,

                  ),

                  

                ),

                

               
                SizedBox(

                  height: 10,

                ),

                Container(

                  // width: 200,

                  child: Align(

                    alignment: Alignment.center,

                    child: Text(

                      desc,

                      maxLines: 3,

                      style: TextStyle(fontSize: 15, color: Colors.grey[500]),

                      textAlign: TextAlign.center,

                    ),

                  ),

                ),

             

                

              ],

            ),

          ),

        ),

      );

    },

  );


  

}