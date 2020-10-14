import 'package:flutter/material.dart';
import 'profile.dart';
import 'homescreen.dart';
import 'shop.dart';


/* Challenge Class UI Design
  Test Page for Backend Test
  Content:  Bottom Navigation Bar
  Function: MaterialPageRoute -> (Profile, Homescreen, Shop) 
*/

class Challenge extends StatefulWidget {
  @override
  _ChallengeState createState() => _ChallengeState();
}

class _ChallengeState extends State<Challenge> {

  int _currentIndex = 2;
  final barColor = const Color(0xFF0A79DF);
  final bgColor = const Color(0xFFFEFDFD);
  
  final wrktColor = const Color (0xFF28CCD3);
  final blackColor = const Color(0xBF000000);


  @override
  Widget build(BuildContext context) {
  // User user = Provider.of<User>(context);
  // final QuerySnapshot result = await Firestore.instance.collection('user').where('uid', isEqualTo: user.uid).getDocuments();
  // final List<DocumentSnapshot>documents = result.documents;
    return new Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text('Challenge'),
      ),

      /*body: Container(
        child: StreamBuilder(
          stream: Firestore.instance.collection('user').snapshots(),
          builder: (context,snapshot) {
            if (!snapshot.hasData) {
              return Container(
                color: Colors.blue,
                child: Center(
                  child: SpinKitRotatingCircle(
                    color: Colors.white,
                    size: 50.0,
                  ),
                ),
              );
            } else{
                return ListView.builder(
                  padding: EdgeInsets.all(10.0),
                  itemBuilder: (context,index) => buildItem(context, snapshot.data.documents[index]),
                  itemCount: snapshot.data.documents.length,
                  );
            }
          }
        ),
      ),

*/


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
}