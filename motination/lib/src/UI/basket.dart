import 'dart:collection';

import 'Workout/workout.dart';
import 'shop.dart';
import 'package:motination/src/UI/shopitem.dart';
import 'package:motination/src/UI/OldButGold/challenge.dart';
import 'package:motination/src/UI/profile.dart';
import 'package:flutter/material.dart';
import 'package:motination/src/UI/homescreen.dart';






class Basket extends StatefulWidget {



final List basketList;
  Basket({this.basketList});

  


 




  //Basket({Key key, @required this.basketlist}) : super(key: key);

  @override



  createState() {

    return BasketState();

  }

}

class BasketState extends State<Basket> {
  

  

int points = 1000;
 int _currentIndex = 3;

 
  final wrktColor = const Color(0xFF28CCD3);
  final blackColor = const Color(0xBF000000);

  final barColor = const Color(0xff191970); //final blue

  final bgColor = const Color(0xFFFEFDFD);

  

   




  @override

  

  Widget build(BuildContext context) {


       
           
     double width = MediaQuery.of(context).size.width * 0.6;

     return Scaffold(

      //backgroundColor: bgColor,

     appBar: AppBar(
        leading: IconButton(
    icon: Icon(Icons.arrow_back, color: Colors.black),
    onPressed: () =>  Navigator.pop(
                context, MaterialPageRoute(builder: (context) => Shoping())),
  ),
            automaticallyImplyLeading: false,
            title: Text('Warenkorb' , style:  Theme.of(context).textTheme.headline1,),
            backgroundColor: bgColor,

            

            
          ),

        

      


      // Main List View With Builder
  body:

  new Stack(
 

  //new Stack(

    
      children: <Widget>[ 

    
     ListView.builder(

  

        itemCount: widget.basketList.length,

        itemBuilder: (context, index) {

          return 
         
          
          GestureDetector(

            onTap: () {

              // This Will Call When User Click On ListView Item

              showBasketDialogFunc(context, widget.basketList[index].img, widget.basketList[index].name, widget.basketList[index].info);

            },

            

            // Card Which Holds Layout Of ListView Item

            child: Card(

              child: Row(

                children: <Widget>[

                  Container(

                    width: 80,

                    height: 100,

                    child: Image.asset(widget.basketList[index].img),

                  ),

                  Padding(

                    padding: const EdgeInsets.all(10.0),

                    child: Column(

                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: <Widget>[

                        Text(

                          widget.basketList[index].name,

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

                            'Punkte ' + widget.basketList[index].points.toString(),
                            

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

                            'Kategorie: ' + widget.basketList[index].category,
                            

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

                            'Wert: ' + widget.basketList[index].value.toString(),
                            

                            maxLines: 3,

                            style: TextStyle(

                                fontSize: 15, color: Colors.grey[500]),

                          ),

                          

                        ),

                        RaisedButton(
          onPressed: ()  async { 

           widget.basketList.remove( widget.basketList[index]);
            setState(() {
             Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Basket(basketList: widget.basketList,)),
     );


    });                          
                        
                          },
                         
                        
                          
          color: Color(0xff191970),
          child: Icon((Icons.remove),
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



Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            width: double.infinity,
            child: FlatButton(
              child: Text('Jetzt Punkte einlösen', style: Theme.of(context).textTheme.bodyText2,),
              shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            ),
              onPressed: () => {},
              color: Color(0xFFff9a00),
              textColor: Colors.white,
            ),
          ),
 ),
                
          

      ],


 ),
  
     

     
     );  
   

  }

}

showBasketDialogFunc(context, img, title, desc) {



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

