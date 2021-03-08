import 'Workout/workout.dart';
import 'shop.dart';
import 'package:motination/src/UI/shopitem.dart';
import 'package:motination/src/UI/OldButGold/challenge.dart';
import 'package:motination/src/UI/profile.dart';
import 'package:flutter/material.dart';
import 'package:motination/src/UI/homescreen.dart';






class Basket extends StatefulWidget {



final Shopitem laufundberg;
  Basket({this.laufundberg});



 




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

    // MediaQuery to get Device Width


    

    double width = MediaQuery.of(context).size.width * 0.6;

     return Scaffold(

      //backgroundColor: bgColor,

     appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text('Einkaufswagen' , style:  Theme.of(context).textTheme.headline1,),
            backgroundColor: bgColor,

            

            
          ),

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


      // Main List View With Builder
  body:

  
     
        
          ListView.builder(

  

        itemCount: 1,

        itemBuilder: (context, index) {

          return 
         
          
          GestureDetector(

            onTap: () {

              // This Will Call When User Click On ListView Item

              showBasketDialogFunc(context, widget.laufundberg.img, widget.laufundberg.name, widget.laufundberg.info);

            },

            

            // Card Which Holds Layout Of ListView Item

            child: Card(

              child: Row(

                children: <Widget>[

                  Container(

                    width: 100,

                    height: 100,

                    child: Image.asset(widget.laufundberg.img),

                  ),

                  Padding(

                    padding: const EdgeInsets.all(10.0),

                    child: Column(

                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: <Widget>[

                        Text(

                          widget.laufundberg.name,

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

                            'Punkte ' + widget.laufundberg.points.toString(),
                            

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

                            'Kategorie: ' + widget.laufundberg.category,
                            

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

                            'Wert: ' + widget.laufundberg.value.toString(),
                            

                            maxLines: 3,

                            style: TextStyle(

                                fontSize: 15, color: Colors.grey[500]),

                          ),

                          

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

      
        
        
     );  
   
      
/*RawMaterialButton(
        fillColor:  Color(0xff191970),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(color: Color(0xff191970))),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Shoping()),
          );
        },
        child: Text("     Punkte einlösen!     ",
            style: Theme.of(context).textTheme.headline2)),
     
   ); */

     

     

  }

}